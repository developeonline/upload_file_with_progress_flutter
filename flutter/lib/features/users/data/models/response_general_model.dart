
class ResponseGeneralModel {
    bool success = true;
    var data;
    String message;

    ResponseGeneralModel({this.success, this.data, this.message});
    factory ResponseGeneralModel.fromJson(Map<String, dynamic> json) {
        return ResponseGeneralModel (
            success: json['success'] as bool,
            data: json['data'] != null ? json['data'] : null,
            message: json['message'] != null ? json['message'] : null,
        );
    }

}