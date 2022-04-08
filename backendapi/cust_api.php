<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
?>
<?php
$server_token="testingAppTesting";
$client_token = getBearerToken();

if($client_token != $server_token){
    response(false, 401, 'Unauthorized', null);
    die();
}
$msg = "";
$currentDirectory = getcwd();
$uploadDirectory = "/images/";
if (isset($_FILES["photo"]["name"]) && isset($_POST['id']) && $_POST['id'] > 0) {

    // other fields
    $id = $_POST['id'];
    $name = $_POST['name'];
    $created_at = date("Y-m-d h:i:sa");
    $updated_at = date("Y-m-d h:i:sa");

    // file operation
    $filename = $_FILES["photo"]["name"];
    $tempname = $_FILES["photo"]["tmp_name"];
    $mem_type = get_mime_type($filename);
    $new_file_name = time().".".$mem_type;
    $folder = "images/".$new_file_name;
    $uploadPath = $currentDirectory . $uploadDirectory . basename($new_file_name);


    $db = mysqli_connect("localhost", "root", "P@ssw0rd", "generic_app");
    //$sql = "INSERT INTO users_table (name, photo, photo_filename_only, created_at, updated_at) VALUES ('$name', '$folder', '$new_file_name', '$created_at', '$updated_at')";
    $sql = "UPDATE users_table set name = '$name', photo = '$folder', photo_filename_only = '$new_file_name', updated_at = '$updated_at' where id = ".$id;

    // Execute query
    $update_query = mysqli_query($db, $sql);
    //$last_id = mysqli_insert_id($db);

    // Now let's move the uploaded image into the folder: image

    try {
        $success = move_uploaded_file($tempname, $uploadPath);
    } catch (Exception $e) {
        echo "error ".$e;
    }




} else {
    response(false, 422, 'Required Paramters', null);
    die();
}

$success_msg = "Image uploaded successfully";
$failed_msg = "Failed to upload image";


function get_mime_type(string $filename)
{
    $extension_list = explode(".", $filename);
    $ext = end($extension_list); //# extra () to prevent notice

    return $ext;
}

$result = mysqli_query($db, "SELECT * FROM users_table where id = ".$id);
$user=[];
if($update_query && $result){
    while($data = mysqli_fetch_array($result))
    {
        $user['id']=$data['id'];
        $user['name']=$data['name'];
        $user['photo']=$data['photo'];
        $user['created_at']=$data['created_at'];
        $user['updated_at']=$data['updated_at'];
        response(true,200, $success_msg, $user);
    }
} else {
    $user=null;
    response(false, 409, $failed_msg, $user);
}


function response($success,$http_status,$status_message,$data)
{
header("HTTP/1.1 ".$http_status);

$response['success']=$success;
$response['http_status']=$http_status;
$response['message']=$status_message;
$response['data']=$data;

$json_response = json_encode($response);
echo $json_response;
}



?>
<?php
/**
 * Get header Authorization
 * */
function getAuthorizationHeader(){
    $headers = null;
    if (isset($_SERVER['Authorization'])) {
        $headers = trim($_SERVER["Authorization"]);
    }
    else if (isset($_SERVER['HTTP_AUTHORIZATION'])) { //Nginx or fast CGI
        $headers = trim($_SERVER["HTTP_AUTHORIZATION"]);
    } elseif (function_exists('apache_request_headers')) {
        $requestHeaders = apache_request_headers();
        // Server-side fix for bug in old Android versions (a nice side-effect of this fix means we don't care about capitalization for Authorization)
        $requestHeaders = array_combine(array_map('ucwords', array_keys($requestHeaders)), array_values($requestHeaders));
        //print_r($requestHeaders);
        if (isset($requestHeaders['Authorization'])) {
            $headers = trim($requestHeaders['Authorization']);
        }
    }
    return $headers;
}

/**
 * get access token from header
 * */
function getBearerToken() {
    $headers = getAuthorizationHeader();
    // HEADER: Get the access token from the header
    if (!empty($headers)) {
        if (preg_match('/Bearer\s(\S+)/', $headers, $matches)) {
            return $matches[1];
        }
    }
    return null;
}
?>

<?php
// http codes
// 409 Conflict
// 415 Unsupported Media Type
// 422 Unprocessable Entity (The request was well-formed but was unable to be followed due to semantic errors.)
// 426 Upgrade Required (The server refuses to perform the request using the current protocol but might be willing to do so after the client upgrades to a different protocol. The server sends an Upgrade header in a 426 response to indicate the required protocol(s).)
// 429 Too Many Requests
// 500 Internal Server Error
// 401 Unauthorized
// 400 Bad Request
// 403 Forbidden
// 404 Not Found
?>