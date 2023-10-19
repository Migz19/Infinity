import 'package:flutter/material.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/views/committees/model/committee_model.dart';
import 'package:infinity/views/committees/providers/committee_details_provider.dart';
import 'package:infinity/widgets/task/task_item.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_assets.dart';
import '../../core/utils/app_color.dart';
import '../../core/utils/app_constants.dart';
import '../../models/task/task_model.dart';

class TasksScreen extends StatefulWidget {
  List<TaskModel> tasksList = [];
  CommitteeModel committee;

  TasksScreen(this.committee);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.committee.name} committeee tasks",style: TextStyle(color: AppColor.primary),),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<TaskModel>>(
        future: fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Container(
                alignment: Alignment.center,
                height: context.height*0.9,
                width: context.width*0.9,
                padding: EdgeInsets.only(top: 30,left: 40,bottom: 10),
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount:
                      widget.tasksList.length,

                  itemBuilder: (BuildContext context, int index) {
                    return TaskItem(
                      task: widget.tasksList[index],
                    );
                  },
                ),
              );
            } else {
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
                    AppConstants.noDataCheckConnection,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColor.second, fontSize: 20),
                  ),
                ],
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(color: AppColor.primary),
            );
          }
        },
      ),
    );
  }

  Future<List<TaskModel>> fetchTasks() async {
    widget.tasksList=   await context
        .read<CommitteeDetailsProvider>()
        .getCommitteeTasks(widget.committee);
     return widget.tasksList;
  }
}
