import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_assets.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/models/user/user_model.dart';
import 'package:infinity/views/committees/providers/committee_details_provider.dart';
import 'package:infinity/views/committees/widgets/committee_card.dart';
import 'package:provider/provider.dart';

import 'model/committee_model.dart';

class MembersScreen extends StatelessWidget {
  CommitteeModel committeeModel;

  MembersScreen(this.committeeModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        title: const Text(
          "Members Details",
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
      backgroundColor: Colors.white,
      body: FutureBuilder<List<UserModel>>(
        future: getCommitteeMembers(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print("snapshot done");
            if (snapshot.hasData) {
              print("snapshot has data");
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: snapshot.data!.isNotEmpty
                          ? GridView.count(
                              crossAxisCount: 3,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 20,
                              children: snapshot.data!
                                  .map(
                                    (data) => GestureDetector(
                                      child: data.photo!.isNotEmpty
                                          ? CustomCard(
                                              data.username, data.photo!, true)
                                          : CustomCard(data.username,
                                              AppAssets.logo, false),
                                    ),
                                  )
                                  .toList(),
                            )
                          : Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  Image.asset(
                                    AppAssets.notFoundIcon,
                                    width: context.width * 0.4,
                                    height: context.height * 0.4,
                                  ),
                                  Text(
                                    "No members found",
                                    style: TextStyle(
                                        color: AppColor.primary, fontSize: 30),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              );
            } else {
              print("snapshot doesn't have data");
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.notFoundIcon,
                      width: context.width * 0.3),
                  SizedBox(
                    height: context.height * 0.1,
                  ),
                  Text(
                    AppAssets.noDataCheckConnection,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColor.second, fontSize: 20),
                  ),
                ],
              );
            }
          } else {
            print("snapshot loading");
            return Center(
              child: CircularProgressIndicator(color: AppColor.primary),
            );
          }
        },
      ),
    );
  }

  Future<List<UserModel>> getCommitteeMembers(BuildContext context) async {
    return await context
        .read<CommitteeDetailsProvider>()
        .getMembersList(committeeModel);
  }
}
