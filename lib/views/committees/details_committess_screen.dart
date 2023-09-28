import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/models/user/user_model.dart';
import 'package:infinity/provider/profile/profile_provider.dart';
import 'package:infinity/views/committees/model/committee_model.dart';
import 'package:infinity/widgets/dynamic_text_widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_type_button.dart';
import '../../widgets/naviagtion.dart';
import 'members_screen.dart';

class DetailsCommitteeScreen extends StatelessWidget {
  DetailsCommitteeScreen({Key? key, required this.committeeModel})
      : super(key: key);
  final CommitteeModel committeeModel;
  List<UserModel> committeeMembers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        title: const Text(
          "Committee Details",
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
      body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: context.height * 0.4,
                  leading: Container(),
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    background:
                        CachedNetworkImage(imageUrl: committeeModel.photoUri),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            committeeModel.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DynamicTextWidget(
                                length: 150,
                                text: committeeModel.description,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              context.read<ProfileProvider>().currentUser != null?  Row(
                                children: [
                                  CustomTypeButton(
                                      text: "Members",
                                      buttonColor:
                                          Colors.yellow.withOpacity(0.3),
                                      textColor: Colors.black,
                                      isLoading: false,
                                      width: 150,
                                      onTap: () {
                                        AppNavigator.customNavigator(
                                            context: context,
                                            screen:
                                                MembersScreen(committeeModel),
                                            finish: false);
                                      }),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomTypeButton(
                                    text: "Tasks",
                                    isLoading: false,
                                    buttonColor: Colors.yellow.withOpacity(0.3),
                                    textColor: Colors.black,
                                    width: 150,
                                    //     onTap: AppNavigator.customNavigator(context: context, screen:CommitteeScreen() , finish: false),
                                  ),
                                ],
                              ):SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )

    );
  }
}
