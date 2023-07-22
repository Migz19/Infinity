import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_assets.dart';
import 'package:infinity/views/committees/details_committess_screen.dart';
import 'package:infinity/views/committees/model/committee_model.dart';
import 'package:infinity/views/committees/widgets/committee_card.dart';
import 'package:infinity/widgets/naviagtion.dart';

class CommitteeScreen extends StatelessWidget {

  List<CommitteeModel> committeesList = [
    CommitteeModel(
        name: "HR", description: "HR Committee", photoUri: AppAssets.hrIcon),
    CommitteeModel(
        name: "Media",
        description: "Media Committee",
        photoUri: AppAssets.mediaIcon),
    CommitteeModel(
        name: "Marketing",
        description: "Marketing Committee",
        photoUri: AppAssets.marketingIcon),
    CommitteeModel(
        name: "Platforms",
        description: "Platforms Committee",
        photoUri: AppAssets.platformsIcon),
    CommitteeModel(
        name: "HighBoard",
        description: "HighBoard Committee",
        photoUri: AppAssets.boardIcon),
    CommitteeModel(
        name: "FR",
        description: "Fund Raising Committee",
        photoUri: AppAssets.fundIcon),
    CommitteeModel(
        name: "AC",
        description: "AC Committee",
        photoUri: AppAssets.acIcon),
    CommitteeModel(
        name: "PR",
        description: "PR Committee",
        photoUri: AppAssets.prIcon),
    CommitteeModel(
        name: "Events",
        description: "Events Committee",
        photoUri: AppAssets.eventsIcon),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
                children: committeesList
                    .map(
                      (data) => GestureDetector(
                        child: CustomCard(data.name, data.photoUri),
                        onTap: () {
                          AppNavigator.customNavigator(
                              context: context,
                              screen: DetailsCommitteeScreen(
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
      ),
    );
  }
}
