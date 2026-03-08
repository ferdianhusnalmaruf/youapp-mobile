abstract class BaseResponse<T> {
  final int? statusCode;
  final dynamic message;
  final String? error;
  final T? data;

  BaseResponse({this.statusCode, this.message, this.error, this.data});
}
