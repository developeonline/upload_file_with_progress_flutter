
class ResponseLocalGeneralModel {
    bool success = true;
    var data;
    String message;
    String code;

    ResponseLocalGeneralModel(
    {this.success, this.data, this.message});

    bool get responseStatus => success;
    dynamic get responseData => data;
    String get responseMessage => message;


    factory ResponseLocalGeneralModel.fromJson(Map<String, dynamic> json) {
        return ResponseLocalGeneralModel (
            success: json['success'] as bool,
            data: json['data'],
            message: json['message'],
        );
    }


}