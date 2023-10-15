import 'package:flutter/material.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/provider/tasks/TasksProvider.dart';
import 'package:infinity/views/committees/model/committee_model.dart';
import 'package:infinity/views/tasks/task_details_screen.dart';
import 'package:infinity/widgets/naviagtion.dart';
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
      body: FutureBuilder<List<TaskModel>>(
        future: fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print("/////// connection is ok}");
            if (snapshot.hasData) {
              print("///////${snapshot.hasData}");
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: List.generate(
                      context.read<TasksProvider>().committeeTasks.length,
                      (index) => GestureDetector(
                        child: TaskItem(
                          task:context.read<TasksProvider>().committeeTasks[index],
                        ),
                        onTap: () {
                          AppNavigator.customNavigator(
                            context: context,
                            screen: TaskDetailsScreen(
                              taskModel: context.read<TasksProvider>().committeeTasks[index],
                            ),
                            finish: false,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            }else  {
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
          }else {
            return Center(
              child: CircularProgressIndicator(color: AppColor.primary),
            );
          }
        },
      ),
    );
  }

  Future<List<TaskModel>> fetchTasks() async {
    print(widget.committee.tasksIds);
    return await context.read<TasksProvider>().fetchCommitteeTasks(widget.committee);
  }
}
