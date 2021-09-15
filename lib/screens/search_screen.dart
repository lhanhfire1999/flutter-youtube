import 'package:flutter/material.dart';
import 'package:youtube_app/models/Model.dart';
import 'package:youtube_app/widgets/video_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late ListResultVideo videoList;
  final myController = TextEditingController();
  bool loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
            autofocus: true,
            controller: myController,
            decoration: InputDecoration(
              hintText: "Search....",
              suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    myController.text = '';
                  }),
            ),
            onSubmitted: (value) {}),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
              })
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        // child: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Expanded(
        //       child: CustomScrollView(
        //         // controller: scrollController,
        //         slivers: [
        //           SliverList(
        //             delegate: SliverChildBuilderDelegate(
        //               (context, index) {
        //                 if (loading == false) {
        //                   return VideoCard(video: videoList.list[index]);
        //                 }
        //               },
        //               childCount:
        //                   (loading == false) ? videoList.list.length : 0,
        //             ),
        //           ),
        //         ],
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }
}
