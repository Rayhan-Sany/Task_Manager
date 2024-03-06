class ResponseObject{
  final dynamic body;
  final int statusCode;
  final bool isSuccess;
  final String? errorMassage;
  ResponseObject({required this.body,required this.statusCode,required this.isSuccess,this.errorMassage=' '});
}