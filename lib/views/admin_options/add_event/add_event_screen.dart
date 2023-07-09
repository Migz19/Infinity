import 'package:flutter/material.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/widgets/custom_type_button.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_color.dart';
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
}
