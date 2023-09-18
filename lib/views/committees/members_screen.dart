import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_assets.dart';
import 'package:infinity/views/committees/widgets/committee_card.dart';

class MembersScreen extends StatelessWidget {
  List<String> members=['Tarek','Ahmed','Ali','Adel'];
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
                children: members
                    .map(
                      (data) => GestureDetector(
                    child: CustomCard(data, AppAssets.backgroundLogo,false),
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

