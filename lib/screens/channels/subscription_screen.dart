import 'package:flutter/material.dart';
import 'package:youtube_app/models/Model.dart';
import 'package:youtube_app/services/youtube_service.dart';

class Subscriptions extends StatefulWidget {
  const Subscriptions({
    Key? key,
    required this.channelId,
  }) : super(key: key);

  final String channelId;

  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  late List<Channel> listChannel;
  bool loading = true;

  handleGetSubscriptions() async {
    List<Channel> res = (await APIService.instance.getSubscriptions(
      channelId: widget.channelId,
    ));
    setState(() {
      listChannel = res;
      loading = false;
    });
  }

  @override
  void initState() {
    handleGetSubscriptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return _loading();
    } else {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Subscriptions',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              ..._generateChildren(listChannel.length),
            ]))
          ],
        ),
      );
    }
  }

  Widget _loading() {
    return Center(
        child: Text(
      "Loading.......",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ));
  }

  Widget _generateItem(int index) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              margin: const EdgeInsets.symmetric(horizontal: 50.0),
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(listChannel[index].mediumThumbnail),
                radius: 50.0,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 180),
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    listChannel[index].title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _generateChildren(int count) {
    List<Widget> items = [];
    if (count == 0) {
      items.add(Center(child: Text("Channel not exist subscription")));
      return items;
    } else {
      for (int i = 0; i < count; i++) {
        items.add(_generateItem(i));
      }
      return items;
    }
  }
}
