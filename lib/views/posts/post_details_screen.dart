import 'package:flutter/material.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/models/post/post_model.dart';
import 'package:infinity/widgets/dynamic_text_widget.dart';

import '../events/widgets/media_details.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({Key? key, required this.post}) : super(key: key);
  final PostModel post;

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  late PostModel _post;

  @override
  void initState() {
    super.initState();
    _post = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        title: const Text(
          "post Details",
          style: TextStyle(color: Colors.black87),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: context.height * 0.4,
                leading: Container(),
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: MediaDetails(
                    images: _post.filesDownloadUrl,
                    eventID: 0,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DynamicTextWidget(
                              length: 150,
                              text: _post.postDetails.isEmpty
                                  ? 'No Description'
                                  : _post.postDetails,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.timelapse,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
