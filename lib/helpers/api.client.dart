import 'package:dio/dio.dart';

final dio = Dio();
api(String url, {String? method, String? data}) async {
  final response = await dio.request(
    url,
    data: data,
    options: Options(method: method),
  );

  return response;
}
