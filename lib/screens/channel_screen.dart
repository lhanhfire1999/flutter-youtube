import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_app/models/Model.dart';
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
    Tab(child: Text('Video')),
    Tab(child: Text('Playlist')),
    Tab(child: Text('Subcription')),
  ];

  late List _screen = [];

  @override
  void initState() {
    tabController = TabController(length: tabs.length, vsync: this);
    _screen = [
      VideoChannelScreen(channelId: widget.channel.id),
      const Scaffold(body: Center(child: Text('Playlist'))),
      const Scaffold(body: Center(child: Text('Subcription'))),
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
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
              ],
            ),
          ),
          Consumer(
            builder: (context, watch, _) {
              return Stack(
                  children: _screen
                      .asMap()
                      .map(
                        (i, screen) => MapEntry(
                          i,
                          Offstage(
                            offstage: selectedIndex != i,
                            child: screen,
                          ),
                        ),
                      )
                      .values
                      .toList());
            },
          ),
        ],
      ),
    );
  }
}
