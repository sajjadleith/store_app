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

  Future<List<CarouselModel>?> getCarouselData() async {
    try {
      final url = Uri.parse(AppConstant.getCarouselData);
      final response = await http.get(url);
      final decodedData = jsonDecode(response.body);
      final data = (decodedData['data'] as List).map((e) => CarouselModel.fromJson(e)).toList();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print("error $e");
      throw e.toString();
    }
  }
}
