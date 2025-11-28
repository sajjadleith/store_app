import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store/app_constant.dart';
import 'package:store/model/book_model.dart';
import 'package:store/model/login_model.dart';
import 'package:store/model/register_model.dart';

class ApiRepo {
  Future<List<BookModel>> getData() async {
    try {
      final url = Uri.parse(AppConstant.getAllProduct);
      final response = await http.get(url);
      final decodedData = jsonDecode(response.body);
      final data = (decodedData['data'] as List)
          .map((data) => BookModel.fromJson(data))
          .toList();
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
      final encodeData = jsonEncode({
        "email": params.email,
        "passwrod": params.password,
      });
      final response = await http.post(
        url,
        body: encodeData,
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final de = jsonDecode(response.body);
        print("token ${de['token']}");
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
}
