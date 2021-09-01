import 'package:flutter/material.dart';
import 'package:youtube_app/models/Model.dart';
import 'package:youtube_app/screens/channel_screen.dart';
import 'package:youtube_app/services/youtube_service.dart';

class AuthorInfor extends StatefulWidget {
  const AuthorInfor({
    Key? key,
    required this.channelId,
  }) : super(key: key);

  final String channelId;

  @override
  _AuthorInfor createState() => _AuthorInfor();
}

class _AuthorInfor extends State<AuthorInfor> {
  late Channel channel;
  bool loading = true;
  void initState() {
    super.initState();
    _initVideo();
  }

  _initVideo() async {
    Channel channelRes = await APIService.instance.getChannel(
      channelId: widget.channelId,
    );
    setState(() {
      channel = channelRes;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChannelScreen(
                    channel: this.channel,
                  )),
        );
      },
      child: Row(
        children: [
          CircleAvatar(
            foregroundImage: (loading == false)
                ? NetworkImage(channel.mediumThumbnail)
                : NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/YouTube_social_white_square_%282017%29.svg/1200px-YouTube_social_white_square_%282017%29.svg.png'),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    (loading == false) ? channel.title : 'Channel',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 15.0),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'SUBSCRIBE',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
