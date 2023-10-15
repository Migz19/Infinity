import 'package:flutter/material.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/models/user/user_model.dart';
import 'package:infinity/provider/admin_options/add_member/add_member_provider.dart';
import 'package:infinity/widgets/drop_down_list.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_color.dart';
import '../../../widgets/custom_text_feild/custom_text_from_feild.dart';
import '../../../widgets/custom_type_button.dart';
import '../../../widgets/toast/enum.dart';
import '../../../widgets/toast/toast.dart';



class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({Key? key}) : super(key: key);

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController committee = TextEditingController();
  TextEditingController role = TextEditingController();
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
                                            "Add new member",
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
                                            hintColor: AppColor.primary
                                                .withOpacity(0.6),
                                            validator: (value) {
                                              if (value!.isEmpty) return '';

                                              return null;
                                            },
                                            textEditingController: username,
                                            hint: "Username",
                                            label: "Username"),
                                        //Email
                                        CustomTextFromField(
                                            backgroundColor: Colors.white,
                                            hintColor: AppColor.primary
                                                .withOpacity(0.6),
                                            textInputType:
                                            TextInputType.emailAddress,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return '';
                                              }
                                              return null;
                                            },
                                            textEditingController: email,
                                            hint: "ex:infinity@gmail.com",
                                            label: "Email"),
                                        //Phone
                                        CustomTextFromField(
                                            backgroundColor: Colors.white,
                                            hintColor: AppColor.primary
                                                .withOpacity(0.6),
                                            validator: (value) {
                                              if (value!.isEmpty) return '';

                                              return null;
                                            },
                                            textEditingController: phoneNumber,
                                            hint: "ex:01XXXXXXXX",
                                            label: "Phone Number"),
                                        //Phone
                                        CustomTextFromField(
                                            backgroundColor: Colors.white,
                                            hintColor: AppColor.primary
                                                .withOpacity(0.6),
                                            validator: (value) {
                                              if (value!.isEmpty) return '';
                                              return null;
                                            },
                                            textEditingController: password,
                                            hint:
                                            "Password should be greater than 6 characters",
                                            label: "Password"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceEvenly,
                                          children: [
                                            CustomDropDownButton(
                                              height: context.height * 0.05,
                                              width: context.width * 0.32,
                                              context.read<AddMemberProvider>().committeesList,
                                              onItemSelected: (String val) {
                                                committee.text=val;
                                                context.read<AddMemberProvider>().committee=val;
                                              },
                                            ),

                                            SizedBox(
                                              width: context.width * 0.1,),
                                            CustomDropDownButton(
                                              height: context.height * 0.05,
                                              width: context.width * 0.32,
                                              context.read<AddMemberProvider>().rolesList,
                                              onItemSelected: (String val) {
                                                context.read<AddMemberProvider>().role=val;
                                                role.text = val;
                                              },

                                            ),
                                          ],
                                        ),
                                        CustomTypeButton(
                                          text: "Add new member",
                                          isLoading: !context.read<AddMemberProvider>().isAdded ? context.watch<AddMemberProvider>().isLoading : false,
                                          textColor: Colors.white,
                                          buttonColor:
                                          AppColor.primary.withOpacity(0.7),
                                          onTap: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              addNewMember();
                                              if(context.read<AddMemberProvider>().isAdded) {
                                                ToastConfig.showToast(
                                                  context: context,
                                                  msg: "Add member successfully",
                                                  toastStates: ToastStates.Success);
                                                Navigator.pop(context);
                                              }
                                              else{
                                                ToastConfig.showToast(
                                                    context: context,
                                                    msg: context.read<AddMemberProvider>().addMemberMsg,
                                                    toastStates: ToastStates.Error);
                                              }

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
                                        SizedBox(
                                          height: context.height * 0.025,
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

  Future<void> addNewMember() async {
    UserModel user = UserModel(
        username: username.text,
        committee: committee.text,
        role: role.text,
        phoneNumber: phoneNumber.text,
        email: email.text,
        id: "000",
        password: password.text);
    await context.read<AddMemberProvider>().addNewMember(userModel: user);
  }
}
