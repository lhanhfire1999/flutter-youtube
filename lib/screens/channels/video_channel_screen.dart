import 'package:flutter/material.dart';
import 'package:youtube_app/models/Model.dart';
import 'package:youtube_app/services/youtube_service.dart';
import 'package:youtube_app/widgets/video_card.dart';

class VideoChannelScreen extends StatefulWidget {
  const VideoChannelScreen({
    Key? key,
    required this.channelId,
  }) : super(key: key);

  final String channelId;

  @override
  _VideoChannelScreenState createState() => _VideoChannelScreenState();
}

class _VideoChannelScreenState extends State<VideoChannelScreen> {
  late ListResultVideo videosChannel;
  static const double endReachedThreshold = 50;
  bool loading = true;
  final ScrollController scrollController = ScrollController();
  String nextPageToken = '';

  handleGetVideoFromChannel() async {
    ListResultVideo res = (await APIService.instance.getChannelVideos(
      channelId: widget.channelId,
      max: 8,
      nextPageToken: '',
    ));
    setState(() {
      videosChannel = res;
      loading = false;
    });
  }

  void onScroll() {
    if (!scrollController.hasClients) return;

    final thresholdReached =
        scrollController.position.extentAfter < endReachedThreshold;
    if (thresholdReached) {
      setState(() {
        loading = true;
      });
    }
  }

  @override
  void initState() {
    scrollController.addListener(onScroll);
    handleGetVideoFromChannel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (loading == false) {
                        return VideoCard(video: videosChannel.list[index]);
                      }
                    },
                    childCount:
                        (loading == false) ? videosChannel.list.length : 0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
