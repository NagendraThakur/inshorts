import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:inshorts/constants/config.dart';
import 'package:inshorts/repository/api/api.dart';
import 'package:inshorts/shared/toast.dart';

class PutRepository {
  API api = API();

  Future<dynamic> putRequest(
      {required String path, String? editId, required Object body}) async {
    try {
      String editPath = path;
      if (editId != null) {
        editPath = "$path/$editId";
      }

      Map<String, dynamic> headers = {
        "Authorization": "Bearer ${Config.token}",
      };
      Response response = await api.sendRequest.put(
        editPath,
        data: body,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        return responseData;
      } else {
        return null;
      }
    } catch (ex) {
      if (ex is DioException && ex.error is SocketException) {
        toast(message: "No Internet Connection");
      }
      log(ex.toString());
      return null;
    }
  }
}
