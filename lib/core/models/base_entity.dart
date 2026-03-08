abstract class BaseEntity<T> {
  final int? statusCode;
  final dynamic message;
  final String? error;
  final T? data;

  BaseEntity({this.statusCode, this.message, this.error, this.data});
}
