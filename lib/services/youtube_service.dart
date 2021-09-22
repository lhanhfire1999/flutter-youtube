import 'dart:convert';
import 'dart:io';
import 'package:youtube_app/models/Model.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String baseUrlIOS = 'localhost:7070';
  final String baseUrlAndroid = '10.0.2.2:7070';
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
    late String baseUrl = '';
    if (Platform.isAndroid) {
      baseUrl = baseUrlAndroid;
    } else if (Platform.isIOS) {
      baseUrl = baseUrlIOS;
    }
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
      'fields': 'id,title,mediumThumbnail,channels'
    };
    late String baseUrl = '';
    if (Platform.isAndroid) {
      baseUrl = baseUrlAndroid;
    } else if (Platform.isIOS) {
      baseUrl = baseUrlIOS;
    }
    Uri uri = Uri.http(baseUrl, '/tube/channels/$channelId', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      dynamic channelRes = json.decode(res.body);
      Channel channel = Channel.fromMap(channelRes);
      return channel;
    } else {
      throw json.decode(res.body)['error']['message'];
    }
  }

  Future<List<Category>> getCatagories({required String regionCode}) async {
    Map<String, String> parameters = {
      'regionCode': regionCode,
    };
    late String baseUrl = '';
    if (Platform.isAndroid) {
      baseUrl = baseUrlAndroid;
    } else if (Platform.isIOS) {
      baseUrl = baseUrlIOS;
    }
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
    late String baseUrl = '';
    if (Platform.isAndroid) {
      baseUrl = baseUrlAndroid;
    } else if (Platform.isIOS) {
      baseUrl = baseUrlIOS;
    }
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

  Future<ListResultPlaylist> getChannelPlaylists(
      {required String channelId,
      required int max,
      required String nextPageToken,
      List<String>? fields}) async {
    Map<String, String> parameters = {
      'nextPageToken': (nextPageToken.length > 0) ? nextPageToken : '',
      'limit': max.toString(),
      'fields':
          'id,title,mediumThumbnail,duration,categoryId,channelTitle,channelId,count',
      'channelId': channelId
    };
    late String baseUrl = '';
    if (Platform.isAndroid) {
      baseUrl = baseUrlAndroid;
    } else if (Platform.isIOS) {
      baseUrl = baseUrlIOS;
    }
    Uri uri = Uri.http(baseUrl, '/tube/playlists', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      dynamic result = json.decode(res.body);
      ListResultPlaylist listRes = ListResultPlaylist.fromJson(result);
      return listRes;
    } else {
      throw json.decode(res.body)['error']['message'];
    }
  }

  Future<ListResultVideo> getVideoList(
      {required String playlistId,
      required String channelId,
      required int max,
      required String nextPageToken,
      List<String>? fields}) async {
    Map<String, String> parameters = {
      'nextPageToken': (nextPageToken.length > 0) ? nextPageToken : '',
      'limit': max.toString(),
      'fields':
          'id,title,mediumThumbnail,duration,categoryId,channelTitle,channelId',
      'playlistId': playlistId,
      'channelId': channelId,
    };
    late String baseUrl = '';
    if (Platform.isAndroid) {
      baseUrl = baseUrlAndroid;
    } else if (Platform.isIOS) {
      baseUrl = baseUrlIOS;
    }
    Uri uri = Uri.http(baseUrl, '/tube/videos', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      dynamic result = json.decode(res.body);
      ListResultVideo listVideo = ListResultVideo.fromJson(result);
      return listVideo;
    } else {
      throw json.decode(res.body)['error']['message'];
    }
  }

  Future<List<Channel>> getSubscriptions({required String channelId}) async {
    late String baseUrl = '';
    if (Platform.isAndroid) {
      baseUrl = baseUrlAndroid;
    } else if (Platform.isIOS) {
      baseUrl = baseUrlIOS;
    }
    Uri uri = Uri.http(baseUrl, '/tube/channels/subscriptions/$channelId');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      List<dynamic> results = json.decode(res.body);
      List<Channel> subscriptions = [];
      results.forEach((item) {
        subscriptions.add(Channel.fromMap(item));
      });
      return subscriptions;
    } else {
      throw json.decode(res.body)['error']['message'];
    }
  }

  Future<ListResultVideo> getSearchVideos({
    required String q,
    required int max,
    required String nextPageToken,
    List<String>? fields,
  }) async {
    Map<String, String> parameters = {
      'nextPageToken': (nextPageToken.length > 0) ? nextPageToken : '',
      'limit': max.toString(),
      'fields':
          'id,title,mediumThumbnail,duration,categoryId,channelTitle,channelId',
      'q': q,
    };
    late String baseUrl = '';
    if (Platform.isAndroid) {
      baseUrl = baseUrlAndroid;
    } else if (Platform.isIOS) {
      baseUrl = baseUrlIOS;
    }
    Uri uri = Uri.http(baseUrl, '/tube/videos/search', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) {
      dynamic result = json.decode(res.body);
      ListResultVideo listRes = ListResultVideo.fromJson(result);
      return listRes;
    } else {
      throw json.decode(res.body)['error']['message'];
    }
  }
}
