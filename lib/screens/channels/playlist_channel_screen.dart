import 'package:flutter/material.dart';

class PlaylistChannel extends StatefulWidget {
  const PlaylistChannel({Key? key}) : super(key: key);

  @override
  _PlaylistChannelState createState() => _PlaylistChannelState();
}

class _PlaylistChannelState extends State<PlaylistChannel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ..._generateChildren(5),
              ],
            ),
          )
        ],
      ),
    );
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
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/YouTube_social_white_square_%282017%29.svg/1200px-YouTube_social_white_square_%282017%29.svg.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  width: 70.0,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black45),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '17',
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
                        'Martin Garrix feat. John Martin - Higher Ground (DubVision Remix)',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  Text('The Chainsmorker'),
                  Text('11 videos'),
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

    for (int i = 0; i < count; i++) {
      items.add(_generateItem(i));
    }
    return items;
  }
}
