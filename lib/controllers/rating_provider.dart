import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:store/app_constant.dart';
import 'package:store/core/app_constains.dart';
import 'package:store/core/enums/request_state.dart';
import 'package:store/core/generale_state.dart';
import 'package:store/core/services/shared_pref_service.dart';
import 'package:store/repo/api_repo.dart';

class RatingProvider extends ChangeNotifier{
  final ApiRepo apiRepo = ApiRepo();
  GeneralState generalState = GeneralState(requestState: RequestState.empty);
  postRate({required rate, bookId}) async {
    try{
      final url = Uri.parse("${AppConstant.addRatingUrl}$bookId");
      final encodedData = jsonEncode( {"rate": rate});
      final header = {
        "Content-Type": "application/json",
        "Authorization":
        "Bearer ${SharedPrefServcie.getData(AppConstain.token)}",
      };
      final respones = await http.post(url, body: encodedData, headers: header);
      final data = jsonDecode(respones.body);

    } catch (e) {
      print("error in repo = ${e.toString()}");
      throw e.toString();
  } 
}
}