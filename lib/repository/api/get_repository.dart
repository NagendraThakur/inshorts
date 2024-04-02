import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:inshorts/repository/api/api.dart';

class GetRepository {
  API api = API();
  static String news = "/v1/news";
  static String interest = "/v1/category";

  Future<dynamic> getRequest({
    required String path,
    Map<String, dynamic>? additionalHeader,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      // Map<String, dynamic> headers = {
      //   "Authorization": "Bearer ${Config.userAuthenticationToken}"
      // };
      // // Merge additional headers if they are not null or empty
      // if (additionalHeader != null && additionalHeader.isNotEmpty) {
      //   headers.addAll(additionalHeader);
      // }
      Response response = await api.sendRequest.get(
        path,
        data: data,
        queryParameters: queryParameters,
        // options: Options(headers: headers),
      );
      return response.data;
    } catch (ex) {
      log(ex.toString());
      return null;
    }
  }
}
