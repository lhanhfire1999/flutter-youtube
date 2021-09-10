import 'package:flutter/material.dart';
import 'package:youtube_app/models/Model.dart';
import 'package:youtube_app/services/youtube_service.dart';

class PlaylistChannel extends StatefulWidget {
  const PlaylistChannel({
    Key? key,
    required this.channelId,
  }) : super(key: key);

  final String channelId;

  @override
  _PlaylistChannelState createState() => _PlaylistChannelState();
}

class _PlaylistChannelState extends State<PlaylistChannel> {
  final ScrollController scrollController = ScrollController();
  static const double endReachedThreshold = 50;
  late List<Playlist> playlistsChannel;
  late bool loadingFirst = true;
  bool isLoading = true;
  String nextPageToken = '';

  handleGetPlaylistFromChannel() async {
    ListResultPlaylist res = await APIService.instance.getChannelPlaylists(
      channelId: widget.channelId,
      max: 5,
      nextPageToken: nextPageToken,
    );

    setState(() {
      playlistsChannel = res.list;
      nextPageToken = res.nextPageToken;
      loadingFirst = false;
    });
  }

  _handleLoadMore() async {
    setState(() {
      isLoading = true;
    });
    ListResultPlaylist res = await APIService.instance.getChannelPlaylists(
      channelId: widget.channelId,
      max: 1,
      nextPageToken: nextPageToken,
    );
    if (res.nextPageToken != nextPageToken && nextPageToken != '') {
      setState(() {
        playlistsChannel.addAll(res.list);
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
    handleGetPlaylistFromChannel();
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
      return _loadingWidget();
    } else {
      return Scaffold(
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text(
                      'Created playlists',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(),
                  ..._generateChildren(playlistsChannel.length),
                  isLoading
                      ? _loadingWidget()
                      : SizedBox(
                          width: 0,
                          height: 0,
                        )
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  Widget _generateItem(int index) {
    return Container(
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
                  playlistsChannel[index].mediumThumbnail,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  width: 70.0,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black87),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          playlistsChannel[index].count.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Icon(
                            Icons.playlist_play,
                            size: 30.0,
                          ),
                        ),
                      ],
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
                        playlistsChannel[index].title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  Text(playlistsChannel[index].title),
                  Text(playlistsChannel[index].count.toString() + ' videos'),
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
    );
  }

  List<Widget> _generateChildren(int count) {
    List<Widget> items = [];
    if (count == 0) {
      items.add(Text("This channel doesn't have playlist."));
      return items;
    } else {
      for (int i = 0; i < count; i++) {
        items.add(_generateItem(i));
      }
      return items;
    }
  }

  Widget _loadingWidget() {
    return Text(
      "Loading.......",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
