import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store/app_constant.dart';
import 'package:store/core/app_constains.dart';
import 'package:store/core/services/shared_pref_service.dart';
import 'package:store/model/book_model.dart';
import 'package:store/model/carousel_model.dart';
import 'package:store/model/categories_model.dart';
import 'package:store/model/comment_model.dart';
import 'package:store/model/comment_param_model.dart';
import 'package:store/model/favourit_model.dart';
import 'package:store/model/login_model.dart';
import 'package:store/model/rating_model.dart';
import 'package:store/model/register_model.dart';
import 'package:store/screens/book_details.dart';

class ApiRepo {
  Future<List<BookModel>> getData() async {
    try {
      final url = Uri.parse(AppConstant.getAllProduct);
      final response = await http.get(url);
      final decodedData = jsonDecode(response.body);
      final data = (decodedData['data'] as List).map((data) => BookModel.fromJson(data)).toList();
      return data;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<BookModel> getCommentData(String id) async {
    try {
      final url = Uri.parse("${AppConstant.getAllProduct}/$id");
      final response = await http.get(url);
      final decodedData = jsonDecode(response.body);
      final data = BookModel.fromJson(decodedData['data']);
      return data;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<String> login(LoginModel params) async {
    try {
      final url = Uri.parse(AppConstant.loginUrl);
      final encodeData = jsonEncode({"email": params.email, "passwrod": params.password});
      final response = await http.post(
        url,
        body: encodeData,
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final de = jsonDecode(response.body);
        print("token ${de['token']}");
        SharedPrefServcie.setData(AppConstain.token, de['data']['token']);
        return de['data']['token'];
      } else {
        print(response.statusCode);
      }
      return ":";
    } catch (e) {
      print("error $e");
      throw e.toString();
    }
  }

  Future<String> register(RegisterModel params) async {
    try {
      final url = Uri.parse(AppConstant.registerUrl);
      final encodedData = jsonEncode({
        "username": params.username,
        "email": params.email,
        "password": params.password,
      });
      final resonse = await http.post(
        url,
        body: encodedData,
        headers: {"Content-Type": "application/json"},
      );
      if (resonse.statusCode == 200 || resonse.statusCode == 201) {
        final dData = jsonDecode(resonse.body);
        return dData["data"];
      } else {
        print(resonse.statusCode);
      }
      return ":";
    } catch (e) {
      print("error $e");
      throw e.toString();
    }
  }

  Future<List<CommentModel>> getCommentDatas(String id) async {
    try {
      final url = Uri.parse("${AppConstant.commentUrl}/$id");
      final response = await http.get(url);

      final decodedData = jsonDecode(response.body);

      // If no data
      if (decodedData['data'] == null) {
        return [];
      }

      return (decodedData['data'] as List).map((data) => CommentModel.fromJson(data)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<CommentModel> postComment(CommentParamModel param) async {
    try {
      final url = Uri.parse("${AppConstant.addCommentUrl}/${param.bookId}");
      final encodedData = jsonEncode(param.toJson());
      final header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SharedPrefServcie.getData(AppConstain.token)}",
      };

      final response = await http.post(url, body: encodedData, headers: header);
      final data = jsonDecode(response.body);
      final success = CommentModel.fromJson(data['data']);
      return success;
    } catch (e) {
      print("error in repo = ${e.toString()}");
      throw e.toString();
    }
  }

  Future<List<CategoriesModel>> getCategoryData() async {
    try {
      final url = Uri.parse(AppConstant.getAllCategories);
      final response = await http.get(url);
      final decodedData = jsonDecode(response.body);
      final data = (decodedData['data'] as List).map((dD) => CategoriesModel.fromJson(dD)).toList();
      return data;
    } catch (e) {
      print("error $e");
      throw e.toString();
    }
  }

  Future<List<CarouselModel>> getCarouselData() async {
    try {
      final url = Uri.parse(AppConstant.getCarouselData);

      final token = SharedPrefServcie.getData(AppConstain.token);
      print("✅ CAROUSEL TOKEN => $token");

      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $token", "accept": "*/*"},
      );

      print("✅ CAROUSEL STATUS => ${response.statusCode}");
      print("✅ CAROUSEL BODY => ${response.body}");

      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = (decodedData['data'] as List).map((e) => CarouselModel.fromJson(e)).toList();

        print("✅ CAROUSEL DATA LENGTH => ${data.length}");
        return data;
      } else {
        return [];
      }
    } catch (e) {
      print("❌ CAROUSEL ERROR => $e");
      return [];
    }
  }

  Future<CommentModel> updateComment(String id, String content) async {
    final url = Uri.parse("${AppConstant.updateCommentUrl}$id");

    final header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${SharedPrefServcie.getData(AppConstain.token)}",
    };

    final body = jsonEncode({"id": id, "content": content});

    final response = await http.put(url, body: body, headers: header);

    final decoded = jsonDecode(response.body);

    return CommentModel.fromJson(decoded["data"]);
  }

  Future<bool> deleteComment(String commentId) async {
    final url = Uri.parse("${AppConstant.deleteCommentUrl}$commentId");

    final header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${SharedPrefServcie.getData(AppConstain.token)}",
    };

    final response = await http.delete(url, headers: header);

    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<List<FavouriteModel>> getFavourites() async {
    final token = SharedPrefServcie.getData(AppConstain.token);

    print("FAV TOKEN => $token");

    final response = await http.get(
      Uri.parse(AppConstant.getAllFavouriteUrl),
      headers: {"Authorization": "Bearer $token", "accept": "*/*"},
    );

    print("FAV STATUS => ${response.statusCode}");
    print("FAV BODY => ${response.body}");

    final decoded = jsonDecode(response.body);

    if (decoded['data'] == null) {
      return [];
    }

    return (decoded['data'] as List).map((e) => FavouriteModel.fromJson(e)).toList();
  }

  Future<bool> addToFavourite(String bookId) async {
    final url = Uri.parse("${AppConstant.baseUrl}Favorite/Add/$bookId");

    final header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${SharedPrefServcie.getData(AppConstain.token)}",
    };

    final response = await http.post(url, headers: header);

    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<bool> updatePassword({required String oldPassword, required String newPassword}) async {
    try {
      final url = Uri.parse("${AppConstant.baseUrl}Profile/Password");

      final header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SharedPrefServcie.getData(AppConstain.token)}",
      };

      final body = jsonEncode({"oldPassword": oldPassword, "newPassword": newPassword});

      final response = await http.put(url, headers: header, body: body);

      print("UPDATE PASS STATUS => ${response.statusCode}");
      print("UPDATE PASS BODY => ${response.body}");

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("UPDATE PASS ERROR => $e");
      return false;
    }
  }
}
