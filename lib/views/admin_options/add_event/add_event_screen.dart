import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infinity/controller/converters.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/models/event/event_model.dart';
import 'package:infinity/widgets/custom_type_button.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_color.dart';
import '../../../provider/admin_options/add_event/add_event_provider.dart';
import '../../../widgets/custom_text_feild/custom_text_from_feild.dart';
import '../../../widgets/toast/enum.dart';
import '../../../widgets/toast/toast.dart';

class AddEventScreen extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController description = TextEditingController();
  String eventTime = "";
  List<File>? eventFiles;
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
                                            "Add new event",
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
                                                        date.text =
                                                            convertDateToString(
                                                                value!, true),
                                                        showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                        ).then((val) {
                                                          if (val != null) {
                                                            if(val.hour>=10) {
                                                              eventTime =
                                                                " ${val.hour}:${val.minute}:00";
                                                            }
                                                            else {
                                                              eventTime =
                                                            " 0${val.hour}:${val.minute}:00";
                                                            }
                                                          }
                                                        }),
                                                      }),
                                                },
                                            textEditingController: date,
                                            hint: date.text.isNotEmpty
                                                ? date.text
                                                : "Event day ex:20-09-2023",
                                            label: "Event day"),
                                        //Location
                                        CustomTextFromField(
                                            backgroundColor: Colors.white,
                                            hintColor: AppColor.primary
                                                .withOpacity(0.6),
                                            validator: (value) {
                                              if (value!.isEmpty) return '';

                                              return null;
                                            },
                                            textEditingController: location,
                                            hint: "Event Location",
                                            label: "Event location"),
                                        //Description
                                        CustomTextFromField(
                                            backgroundColor: Colors.white,
                                            hintColor: AppColor.primary
                                                .withOpacity(0.6),
                                            validator: (value) {
                                              if (value!.isEmpty) return '';
                                              return null;
                                            },
                                            textEditingController: description,
                                            hint: "Description",
                                            label: "Event description"),

                                        SizedBox(
                                          height: context.height * 0.025,
                                        ),
                                        CustomTypeButton(
                                          text: "Pick Files",
                                          width: context.width * 0.4,
                                          buttonColor: AppColor.primary,
                                          onTap: () async {
                                            eventFiles = await context
                                                .read<AddEventProvider>()
                                                .pickFiles();
                                          },
                                        ),
                                        CustomTypeButton(
                                          text: "Add new event",
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
                                          onTap: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              await _addNewEvent(context);
                                              ToastConfig.showToast(
                                                  context: context,
                                                  msg:
                                                      "Added event successfully",
                                                  toastStates:
                                                      ToastStates.Success);
                                            } else {
                                              ToastConfig.showToast(
                                                context: context,
                                                msg:
                                                    "Please enter required data",
                                                toastStates: ToastStates.Error,
                                              );
                                            }
                                            Navigator.pop(context);
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

  Future<bool> _addNewEvent(BuildContext context) async {
    if (eventTime.isEmpty) {
      eventTime = "00:00:00";
    }
    date.text += eventTime;
    EventModel event = EventModel(
        title: title.text,
        date: date.text,
        location: location.text,
        description: description.text);
    event.eventFiles = eventFiles;

    await context.read<AddEventProvider>().addNewEvent(eventModel: event);
    return true;
  }
}
