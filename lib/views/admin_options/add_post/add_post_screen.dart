import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/models/post/post_model.dart';
import 'package:infinity/provider/admin_options/add_post/add_post_provider.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatelessWidget {
  TextEditingController postController = TextEditingController();
   List<File>? post_files;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () { Navigator.pop(context); },
                        child: Text(
                          "Cancel",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: AppColor.second,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 35,
                        decoration: BoxDecoration(
                            color: AppColor.second,
                            borderRadius: BorderRadius.circular(7)),
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: ()  {_submitPost(context);Navigator.pop(context);},
                          child: Text(
                            "Post",
                            selectionColor: AppColor.primary,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    width: context.width * 0.9,
                    height: context.height * 0.8,
                    child: TextFormField(
                      maxLines: null,
                      controller: postController,
                      decoration: const InputDecoration(
                          hintText: "What's happening..?",
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              // Todo ozbot el design
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  context
                      .read<AddPostProvider>()
                      .pickFiles()
                      .then((files) => {
                    post_files=files,
                  {print("99999 images in widget not empty ${files?.first.path}")},
                      });
                },
                backgroundColor: AppColor.second,
                child: const Icon(
                  Icons.image,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _submitPost(BuildContext context) {
    if (postController.text.isNotEmpty) {
      PostModel post = PostModel(postDetails: postController.text);
      post.files = post_files;

      context.read<AddPostProvider>().addNewPost(post);
      return true;
    }
    return false;
  }
}
