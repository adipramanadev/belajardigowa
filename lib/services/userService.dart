import "package:belajardigowa/constant/apiconstant.dart";
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:belajardigowa/models/usermodel.dart';

class UserService {
  //get data from user service
  Future<List<UserModel>> getUsers() async {
    final response =
        await http.get(Uri.parse(ApiConstant.BASE_URL + ApiConstant.GET_USERS));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => UserModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  //search user by name
  Future<List<UserModel>> searchUser(String name) async {
    final response = await http.get(Uri.parse(
        ApiConstant.BASE_URL + ApiConstant.GET_USERS + "?name=$name"));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => UserModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
