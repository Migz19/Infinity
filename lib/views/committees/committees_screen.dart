import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_assets.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/views/committees/details_committess_screen.dart';
import 'package:infinity/views/committees/model/committee_model.dart';
import 'package:infinity/views/committees/providers/committee_details_provider.dart';
import 'package:infinity/views/committees/widgets/committee_card.dart';
import 'package:infinity/widgets/naviagtion.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_constants.dart';

class CommitteeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<void>(
        future: getCommitteesDetails(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 3,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 20,
                        shrinkWrap: true,
                        children:context.read<CommitteeDetailsProvider>().committeesList
                            .map(
                              (data) => GestureDetector(
                                child:
                                    CustomCard(data.name, data.photoUri, true),
                                onTap: () {
                                  AppNavigator.customNavigator(
                                      context: context,
                                      screen: CommitteeDetailsScreen(
                                        committeeModel: data,
                                      ),
                                      finish: false);
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              );
            } else  {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.notFoundIcon,width: context.width*0.3),
                  SizedBox(height: context.height*0.1,),
                  Text(
                    AppConstants.noDataCheckConnection,

                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColor.second,fontSize:20),
                  ),
                ],
              );
            }
          }
          else {
            return Center(
              child: CircularProgressIndicator(color: AppColor.primary),
            );
          }
        },

      ),
    );
  }

  Future<List<CommitteeModel>> getCommitteesDetails(BuildContext context) async {
   return await context
        .read<CommitteeDetailsProvider>()
        .getCommitteesList();
  }
}
