import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:nuuz/util/dio/api_constants.dart';
import 'package:nuuz/util/log_print.dart';

class ImageRepository {
  static final ImageRepository _repository = ImageRepository._intrnal();

  factory ImageRepository() => _repository;

  ImageRepository._intrnal();

  // Dio dio = HttpService().to();

  Future<String> uploadImage(String file) async {
    try {
      String fileName = file.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file, filename: fileName, contentType: MediaType("image", "jpeg")),
      });
      final dio = Dio();
      dio.options.headers["Content-Type"] = "multipart/form-data";
      final response = await dio.post(
        "${APIConstants.baseUrl}image/uploadImage",
        data: formData,
        // options: Options(contentType: "multipart/form-data"),
      );
      if (response.statusCode == 200) {
        safePrint(response);
        final body = response.data;
        return body["image_url"];
      }
      return response.data['id'];
    } catch (e) {
      safePrint(e);
      rethrow;
    }
  }

  Future<String> deleteImage() async {
    try {
      final dio = Dio();
      //dio.options.headers["Content-Type"] = "multipart/form-data";
      final response = await dio.put(
        "${APIConstants.baseUrl}user/update",
        data: {"image": null},
        // options: Options(contentType: "multipart/form-data"),
      );
      if (response.statusCode == 200) {
        return 'true';
      } else {
        return 'false';
      }
    } catch (e) {
      safePrint(e);
      rethrow;
    }
  }
}
