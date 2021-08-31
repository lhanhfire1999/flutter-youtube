import 'dart:convert';
import 'dart:io';
import 'package:youtube_app/models/Model.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String baseUrl = '10.0.2.2:7070';
  Future<ListResultVideo> getPopularVideoByRegion(
      {required String regionCode,
      required int max,
      required String categoryId,
      required String nextPageToken,
      List<String>? fields}) async {
    Map<String, String> parameters = {
      'regionCode': regionCode,
      'categoryId': (categoryId.length > 0) ? categoryId : '',
      'nextPageToken': (nextPageToken.length > 0) ? nextPageToken : '',
      'limit': max.toString(),
      'fields':
          'id,title,mediumThumbnail,duration,categoryId,channelTitle,channelId'
    };
    Uri uri = Uri.http(baseUrl, '/tube/videos/popular', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      dynamic result = json.decode(res.body);
      ListResultVideo listRes = ListResultVideo.fromJson(result);
      return listRes;
    } else {
      throw json.decode(res.body)['error']['message'];
    }
  }

  Future<Channel> getChannel({required String channelId}) async {
    Map<String, String> parameters = {
      'id': channelId,
      'fields': 'id,title,mediumThumbnail'
    };
    Uri uri = Uri.http(baseUrl, '/tube/channels/list', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      dynamic channelRes = json.decode(res.body);
      Channel channel = Channel.fromMap(channelRes[0]);
      return channel;
    } else {
      throw json.decode(res.body)['error']['message'];
    }
  }

  Future<List<Category>> getCatagories({required String regionCode}) async {
    Map<String, String> parameters = {
      'regionCode': regionCode,
    };
    Uri uri = Uri.http(baseUrl, '/tube/category', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> categoryRes = json.decode(res.body);
      List<Category> categories = [];
      categoryRes.forEach((item) {
        categories.add(Category.fromMap(item));
      });
      return categories;
    } else {
      throw json.decode(res.body)['error']['message'];
    }
  }

  Future<ListResultVideo> getRelatedVideos(
      {required String videoId,
      required int max,
      required String nextPageToken,
      List<String>? fields}) async {
    Map<String, String> parameters = {
      'nextPageToken': (nextPageToken.length > 0) ? nextPageToken : '',
      'limit': max.toString(),
      'fields':
          'id,title,mediumThumbnail,duration,categoryId,channelTitle,channelId'
    };
    Uri uri = Uri.http(baseUrl, '/tube/videos/$videoId/related', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      dynamic result = json.decode(res.body);
      ListResultVideo listRes = ListResultVideo.fromJson(result);
      return listRes;
    } else {
      throw json.decode(res.body)['error']['message'];
    }
  }
}
