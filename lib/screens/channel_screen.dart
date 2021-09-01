import 'package:flutter/material.dart';
import 'package:youtube_app/models/Model.dart';

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
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
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
                  leadingWidth: 100.0,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(widget.channel.title),
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
          )
        ],
      ),
    );
  }
}
