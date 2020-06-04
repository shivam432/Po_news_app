import 'dart:convert';
import 'package:doenlaod_app/services/webservice.dart';
import 'package:doenlaod_app/utilities/constants.dart';

class NewsArticle {
  final String title;
  final String descrption;
  final String urlToImage;

  NewsArticle({this.title, this.descrption, this.urlToImage});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
        title: json['title'],
        descrption: json['description'],
        urlToImage:
            json['urlToImage'] ?? Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL);
  }

  static Resource<List<NewsArticle>> get all {
    return Resource(
        url: Constants.HEADLINE_NEWS_URL,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result['articles'];
          print(list);
          return list.map((model) => NewsArticle.fromJson(model)).toList();
        });
  }
}
