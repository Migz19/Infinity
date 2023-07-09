import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_assets.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/views/committees/model/committee_model.dart';
import 'package:infinity/views/committees/widgets/committee_card.dart';
import 'package:infinity/views/committees/widgets/details_committess_screen.dart';
import 'package:infinity/widgets/naviagtion.dart';

class CommitteeScreen extends StatelessWidget {
  CommitteeScreen({Key? key}) : super(key: key);
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
        name: "Sales",
        description: "Sales Committee",
        photoUri: AppAssets.salesIcon),
    CommitteeModel(
        name: "HighBoard",
        description: "HighBoard Committee",
        photoUri: AppAssets.boardIcon),
    CommitteeModel(
        name: "FR",
        description: "Fund Raising Committee",
        photoUri: AppAssets.mediaIcon),
    CommitteeModel(
        name: "Marketing",
        description: "HR Committee",
        photoUri: AppAssets.marketingIcon),
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Committees",
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: AppColor.tertiary),
        ),
        toolbarHeight: 0.0,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchBar(
              controller: searchController,
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
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
