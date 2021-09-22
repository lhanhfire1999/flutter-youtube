import 'package:flutter/material.dart';
import 'package:youtube_app/models/Model.dart';
import 'package:youtube_app/services/youtube_service.dart';
import 'package:youtube_app/utils/format_duration.dart';
import 'package:youtube_app/widgets/loading.dart';

class VideoPlaylistChannel extends StatefulWidget {
  const VideoPlaylistChannel({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  final Playlist playlist;

  @override
  _VideoPlaylistChannelState createState() => _VideoPlaylistChannelState();
}

class _VideoPlaylistChannelState extends State<VideoPlaylistChannel> {
  final ScrollController scrollController = ScrollController();
  static const double endReachedThreshold = 50;
  late List<Video> videoList;
  String nextPageToken = '';
  bool loadingFirst = true;
  bool isLoading = false;

  handleGetVideoListFormChannel() async {
    ListResultVideo res = await APIService.instance.getVideoList(
      channelId: '',
      playlistId: widget.playlist.id,
      max: 5,
      nextPageToken: nextPageToken,
    );
    setState(() {
      videoList = res.list;
      nextPageToken = res.nextPageToken;
      loadingFirst = false;
    });
  }

  _handleLoadMore() async {
    setState(() {
      isLoading = true;
    });
    ListResultVideo res = await APIService.instance.getVideoList(
      channelId: '',
      playlistId: widget.playlist.id,
      max: 5,
      nextPageToken: nextPageToken,
    );
    if (res.nextPageToken != nextPageToken && nextPageToken != '') {
      setState(() {
        videoList.addAll(res.list);
        nextPageToken = res.nextPageToken;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void onScroll() {
    if (!scrollController.hasClients) return;

    final thresholdReached =
        scrollController.position.extentAfter < endReachedThreshold;
    if (thresholdReached) {
      _handleLoadMore();
    }
  }

  @override
  void initState() {
    scrollController.addListener(onScroll);
    handleGetVideoListFormChannel();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loadingFirst) {
      return Loading();
    } else {
      return Scaffold(
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              leadingWidth: 30.0,
              title: Container(
                child: Text(
                  widget.playlist.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.cast_connected),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _introPlaylist(),
                  Container(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    width: double.infinity,
                    child: Text(
                      '${widget.playlist.count.toString()} videos',
                      style: TextStyle(fontSize: 16.0, color: Colors.white70),
                    ),
                  ),
                  const Divider(),
                  ..._generateChildren(videoList.length, context),
                  isLoading
                      ? Loading()
                      : SizedBox(
                          width: 0,
                          height: 0,
                        )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _introPlaylist() {
    return Container(
      padding: const EdgeInsets.fromLTRB(2, 10, 10, 10),
      decoration: BoxDecoration(color: Colors.black87),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15.0),
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    widget.playlist.title,
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
                Text(
                  widget.playlist.channelTitle,
                  style: TextStyle(fontSize: 16.0, color: Colors.white70),
                ),
              ],
            ),
          ),
          _actions(),
        ],
      ),
    );
  }

  Widget _actions() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shuffle),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.replay),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.library_add),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.download),
        ),
      ],
    );
  }

  List<Widget> _generateChildren(int count, BuildContext context) {
    List<Widget> items = [];
    if (count == 0) {
      items.add(Text("This playlist doesn't have video."));
      return items;
    } else {
      for (int i = 0; i < count; i++) {
        items.add(_generateItem(i, context));
      }
      return items;
    }
  }

  Widget _generateItem(int index, BuildContext context) {
    return GestureDetector(
      onTap: () => {print('Video...')},
      child: Container(
        margin: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 10.0),
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 9,
              child: Stack(
                children: [
                  Image.network(
                    videoList[index].mediumThumbnail,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                    right: 5.0,
                    bottom: 5.0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black54,
                      ),
                      child: Text(
                        FormatDuration.getTimeString(
                          int.parse(videoList[index].duration),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          videoList[index].title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    Text(videoList[index].channelTitle),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.more_vert,
                size: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
