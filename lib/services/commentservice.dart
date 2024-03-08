//service to get comments from the fake api
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:belajardigowa/models/comments.dart';

class CommentService {
  Future<List<Comments>> getComments() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Comments.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
