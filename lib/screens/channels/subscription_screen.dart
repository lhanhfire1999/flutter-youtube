import 'package:flutter/material.dart';

class Subscriptions extends StatefulWidget {
  const Subscriptions({Key? key}) : super(key: key);

  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  @override
  Widget build(BuildContext context) {
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
            ..._generateChildren(15),
          ]))
        ],
      ),
    );
  }

  Widget _generateItem() {
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
                backgroundImage: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/YouTube_social_white_square_%282017%29.svg/1200px-YouTube_social_white_square_%282017%29.svg.png'),
                radius: 50,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 180),
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'The chainsmorker',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'The chainsmorer',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  '123123',
                  style: TextStyle(
                    fontSize: 16.0,
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

    for (int i = 0; i < count; i++) {
      items.add(_generateItem());
    }

    return items;
  }
}
