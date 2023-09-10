import 'package:flutter/material.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/provider/profile/profile_provider.dart';
import 'package:infinity/widgets/custom_type_button.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_color.dart';
import '../../../provider/admin_options/add_event/add_event_provider.dart';
import '../../../widgets/custom_text_feild/custom_text_from_feild.dart';

class AddEventScreen extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController description = TextEditingController();

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
                                          height: 15,
                                          width: 15,
                                          child: IconButton(
                                              icon: Icon(Icons.image_rounded),
                                              onPressed:()=>_displayPickImageDialogue(context)),
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
                                        //Email
                                        CustomTextFromField(
                                            backgroundColor: Colors.white,
                                            hintColor: AppColor.primary
                                                .withOpacity(0.6),
                                            textInputType: TextInputType.number,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return '';
                                              }
                                              return null;
                                            },
                                            textEditingController: date,
                                            hint: "Event day ex:20",
                                            label: "Event day"),
                                        //Phone
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
                                        //Phone
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
                                          text: "Add new event",
                                          textColor: Colors.white,
                                          buttonColor: Colors.transparent
                                              .withOpacity(0.2),
                                        )
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

  Future _displayPickImageDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: context.height * 0.7,
            alignment: Alignment.bottomCenter,
            child: AlertDialog(
              alignment: Alignment.bottomCenter,
              title: const Text(
                "Choose where to pick image from",
                style: TextStyle(fontSize: 15),
              ),
              content: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            context
                                .read<ProfileProvider>()
                                .uploadImage("camera");
                            Navigator.pop(context);
                          },
                          focusColor: Colors.grey,
                          icon: Image.asset(AppAssets.cameraIcon)),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Camera",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            context
                                .read<ProfileProvider>()
                                .uploadImage("gallery");
                            Navigator.pop(context);
                          },
                          focusColor: Colors.grey,
                          icon: Image.asset(AppAssets.galleryIcon)),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Gallery",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
