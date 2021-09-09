import 'package:flutter/material.dart';
import 'package:youtube_app/models/Model.dart';
import 'package:youtube_app/screens/channels/playlist_channel_screen.dart';
import 'package:youtube_app/screens/channels/subscription_screen.dart';
import 'package:youtube_app/screens/channels/video_channel_screen.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({Key? key, required this.channel}) : super(key: key);
  final Channel channel;
  @override
  _ChannelScreenState createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;
  static const List<Tab> tabs = <Tab>[
    Tab(child: Text('VIDEOS')),
    Tab(child: Text('PLAYLISTS')),
    Tab(child: Text('CHANNELS')),
  ];

  late List<Widget> _screen = [];

  @override
  void initState() {
    tabController = TabController(length: tabs.length, vsync: this);
    _screen = [
      VideoChannelScreen(channelId: widget.channel.id),
      PlaylistChannel(),
      Subscriptions(channelId: widget.channel.id),
    ];
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                leadingWidth: 30.0,
                title: Container(
                  child: Text(
                    widget.channel.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                ],
                bottom: TabBar(
                  isScrollable: true,
                  controller: tabController,
                  tabs: tabs,
                ),
              ),
            ];
          },
          body: TabBarView(
            children: _screen,
            controller: tabController,
          ),
        ),
      ),
    );
  }
}
