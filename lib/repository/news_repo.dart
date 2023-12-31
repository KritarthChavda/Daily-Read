import 'dart:convert';
import 'package:daily_read/models/categories_model.dart';
import 'package:daily_read/models/headline_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsRepo {
  Future<HeadlineModel> fetchHeadlineApi() async {
    String url =
        'https://newsapi.org/v2/everything?q=general&apiKey=2149c5f5c41246b098b849de08bcb07c';

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return HeadlineModel.fromJson(body);
    }
    throw Exception("Error");
  }

  Future<CategoriesModel> fetchCategoryApi(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=${category}&apiKey=2149c5f5c41246b098b849de08bcb07c';

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesModel.fromJson(body);
    }
    throw Exception("Error");
  }
}
