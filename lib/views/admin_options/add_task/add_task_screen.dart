import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/models/task/task_model.dart';
import 'package:infinity/provider/admin_options/add_task/add_task_provider.dart';
import 'package:infinity/widgets/custom_text_feild/custom_text_from_feild.dart';
import 'package:provider/provider.dart';

import '../../../controller/converters.dart';
import '../../../controller/random_id_generator.dart';
import '../../../core/utils/app_assets.dart';
import '../../../provider/admin_options/add_event/add_event_provider.dart';
import '../../../provider/admin_options/add_member/add_member_provider.dart';
import '../../../widgets/custom_type_button.dart';
import '../../../widgets/drop_down_list.dart';
import '../../../widgets/toast/enum.dart';
import '../../../widgets/toast/toast.dart';

class AddTaskScreen extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController deadline = TextEditingController();
  TextEditingController committee = TextEditingController();
  var taskTime = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.backgroundLogo,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
          ),
          Container(
            width: context.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                          tag: 'logo',
                          child: Image.asset(
                            AppAssets.logo,
                            height: context.height * 0.2,
                            width: context.width,
                          )),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Card(
                            color: AppColor.second.withOpacity(0.6),
                            elevation: 1,
                            shadowColor: Colors.grey.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: SizedBox(
                                width: context.width * 0.8,
                                height: context.height * 0.6,
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          width: context.width * 0.6,
                                          child: const Text(
                                            maxLines: 2,
                                            "Assign new task",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),

                                        SizedBox(
                                          height: context.height * 0.025,
                                        ),
                                        //Username
                                        CustomTextFromField(
                                          backgroundColor: Colors.white,
                                          hintColor:
                                              AppColor.primary.withOpacity(0.6),
                                          validator: (value) {
                                            if (value!.isEmpty) return '';

                                            return null;
                                          },
                                          textEditingController: title,
                                          label: "Title",
                                          hint: 'Title',
                                        ),
                                        //Date
                                        CustomTextFromField(
                                            backgroundColor: Colors.white,
                                            hintColor: AppColor.primary
                                                .withOpacity(0.6),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return '';
                                              }
                                              return null;
                                            },
                                            textInputType: TextInputType.none,
                                            ontap: () => {
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101),
                                                  ).then((value) => {
                                                        deadline.text =
                                                            convertDateToString(
                                                                value!, true),
                                                        showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                        ).then((val) {
                                                          if (val != null) {
                                                            if (val.hour >=
                                                                10) {
                                                              taskTime =
                                                                  " ${val.hour}:${val.minute}:00";
                                                            } else {
                                                              taskTime =
                                                                  " 0${val.hour}:${val.minute}:00";
                                                            }
                                                          }
                                                        }),
                                                      }),
                                                },
                                            textEditingController: deadline,
                                            hint: deadline.text.isNotEmpty
                                                ? deadline.text
                                                : "Task deadline ex:20-09-2023",
                                            label: "Task deadline"),

                                        //Description
                                        CustomTextFromField(
                                            backgroundColor: Colors.white,
                                            height: 100,
                                            hintColor: AppColor.primary
                                                .withOpacity(0.6),
                                            validator: (value) {
                                              if (value!.isEmpty) return '';
                                              return null;
                                            },
                                            textEditingController: description,
                                            hint: "Description",
                                            label: "Task description"),
                                        CustomDropDownButton(
                                          height: context.height * 0.05,
                                          width: context.width * 0.5,
                                          context
                                              .read<AddMemberProvider>()
                                              .committeesList,
                                          onItemSelected: (String val) {
                                            committee.text = val;
                                          },
                                        ),
                                        SizedBox(
                                          height: context.height * 0.025,
                                        ),
                                        CustomTypeButton(
                                          text: "Assign new task",
                                          isLoading: !context
                                                  .read<AddEventProvider>()
                                                  .isAdded
                                              ? context
                                                  .watch<AddEventProvider>()
                                                  .isLoading
                                              : false,
                                          textColor: Colors.white,
                                          buttonColor:
                                              AppColor.primary.withOpacity(0.7),
                                          onTap: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _addNewTask(context);
                                              if (context
                                                  .read<AddTaskProvider>()
                                                  .isAdded) {
                                                ToastConfig.showToast(
                                                    context: context,
                                                    msg:
                                                        "Added task successfully",
                                                    toastStates:
                                                        ToastStates.Success);
                                              } else {
                                                ToastConfig.showToast(
                                                    context: context,
                                                    msg: "Failed to add Task ",
                                                    toastStates:
                                                        ToastStates.Warning);
                                              }

                                              Navigator.pop(context);
                                            } else {
                                              ToastConfig.showToast(
                                                context: context,
                                                msg:
                                                    "Please enter required data",
                                                toastStates: ToastStates.Error,
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addNewTask(BuildContext context) async {
    if (taskTime.isEmpty) {
      taskTime = "00:00:00";
    }
    if(deadline.text.length<=10) {
      deadline.text += taskTime;
    }
    TaskModel task = TaskModel(
        description: description.text,
        title: title.text,
        committeeName: committee.text,
        isFinished: false,
        id: generateRandomDocId(),
        deadLine: deadline.text);
    await context.read<AddTaskProvider>().addTask(task);
  }
}
