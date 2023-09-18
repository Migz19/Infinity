import 'package:flutter/material.dart';
import 'package:infinity/views/committees/details_committess_screen.dart';
import 'package:infinity/views/committees/model/committee_model.dart';
import 'package:infinity/views/committees/providers/committee_details_provider.dart';
import 'package:infinity/views/committees/widgets/committee_card.dart';
import 'package:infinity/widgets/naviagtion.dart';
import 'package:provider/provider.dart';

class CommitteeScreen extends StatefulWidget {
  @override
  State<CommitteeScreen> createState() => _CommitteeScreenState();
  List<CommitteeModel> committeesList = [];
}

class _CommitteeScreenState extends State<CommitteeScreen> {
  @override
  void initState() {
    super.initState();
    getCommitteesDetails();
  }

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
                children: widget.committeesList
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
  Future<void>getCommitteesDetails()async{
  await context
        .read<CommitteeDetailsProvider>()
        .getCommitteesList()
        .then((value) => widget.committeesList);
  }
}
