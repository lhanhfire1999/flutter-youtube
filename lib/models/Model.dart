class Video {
  Video(
      {required this.id,
      required this.title,
      required this.duration,
      required this.mediumThumbnail,
      required this.categoryId,
      required this.channelTitle,
      required this.channelId});

  String id;
  String title;
  String duration;
  String mediumThumbnail;
  String categoryId;
  String channelTitle;
  String channelId;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      mediumThumbnail: json['mediumThumnail'] != null
          ? json['mediumThumnail']
          : 'https://i.ytimg.com/vi/' + json['id'] + '/mqdefault.jpg',
      categoryId: json['categoryId'],
      channelTitle: json['channelTitle'],
      channelId: json['channelId']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "duration": duration,
        "mediumThumnail": mediumThumbnail,
        "categoryId": categoryId,
        "channelTitle": channelTitle,
        "channelId": channelId,
      };
}

class Playlist {
  Playlist(
      {required this.id,
      required this.title,
      required this.mediumThumbnail,
      required this.count,
      required this.channelTitle,
      required this.channelId});
  String id;
  String title;
  String mediumThumbnail;
  int count;
  String channelTitle;
  String channelId;

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
      id: json['id'],
      title: json['title'],
      mediumThumbnail: json['mediumThumnail'] != null
          ? json['mediumThumnail']
          : 'https://i.ytimg.com/vi/' + json['id'] + '/mqdefault.jpg',
      count: json['count'] != null ? json['count'] : 0,
      channelTitle: json['channelTitle'],
      channelId: json['channelId']);
}

class Channel {
  final String id;
  final String title;
  final String mediumThumbnail;

  Channel(this.id, this.title, this.mediumThumbnail);
  factory Channel.fromMap(Map<String, dynamic> item) {
    return Channel(item['id'], item['title'], item['mediumThumbnail']);
  }
}

class Category {
  final String id;
  final String title;
  final bool assignable;
  final String channelId;

  Category(this.id, this.title, this.assignable, this.channelId);

  factory Category.fromMap(Map<String, dynamic> item) {
    return Category(
        item['id'], item['title'], item['assignable'], item['channelId']);
  }
}

class ListResultVideo {
  ListResultVideo({required this.list, required this.nextPageToken});

  List<Video> list;
  String nextPageToken;

  factory ListResultVideo.fromJson(Map<String, dynamic> json) =>
      ListResultVideo(
        list: List<Video>.from(json["list"].map((x) => Video.fromJson(x))),
        nextPageToken:
            json["nextPageToken"] != null ? json["nextPageToken"] : '',
      );
}

class ListResultPlaylist {
  ListResultPlaylist({required this.list, required this.nextPageToken});
  List<Playlist> list;
  String nextPageToken;
  factory ListResultPlaylist.fromJson(Map<String, dynamic> json) =>
      ListResultPlaylist(
        list:
            List<Playlist>.from(json["list"].map((x) => Playlist.fromJson(x))),
        nextPageToken:
            json["nextPageToken"] != null ? json["nextPageToken"] : '',
      );
}

abstract class Title {
  final String? title;
  final String? description;
  final DateTime? publishedAt;

  Title(this.title, this.description, this.publishedAt);
}

abstract class LocalizedTitle {
  final String? localizedTitle;
  final String? localizedDescription;

  LocalizedTitle(this.localizedTitle, this.localizedDescription);
}

abstract class ChannelInfo {
  final String? channelId;
  final String? channelTitle;

  ChannelInfo(this.channelId, this.channelTitle);
}

abstract class ListDetail {
  int itemCount;

  ListDetail(this.itemCount);
}

abstract class PageInfo {
  final int? totalResults;
  final int? resultsPerPage;

  PageInfo(this.totalResults, this.resultsPerPage);
}

abstract class ChannelDetail {
  final RelatedPlaylists? relatedPlaylists;

  ChannelDetail(this.relatedPlaylists);
}

abstract class RelatedPlaylists {
  final String? likes;
  final String? favorites;
  final String? uploads;

  RelatedPlaylists(this.likes, this.favorites, this.uploads);
}

abstract class VideoItemDetail {
  final String? videoId;
  final DateTime? videoPublishedAt;

  VideoItemDetail(this.videoId, this.videoPublishedAt);
}

abstract class RegionRestriction {
  final List<String>? allow;
  final List<String>? blocked;

  RegionRestriction(this.allow, this.blocked);
}

abstract class YoutubeVideoDetail {
  final String? duration;
  final String? dimension;
  final String? definition;
  final String? caption;
  final bool? licensedContent;
  final String? projection;
  final RegionRestriction? regionRestriction;

  YoutubeVideoDetail(
      this.duration,
      this.dimension,
      this.definition,
      this.caption,
      this.licensedContent,
      this.projection,
      this.regionRestriction);
}
