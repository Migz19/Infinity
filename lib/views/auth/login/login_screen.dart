import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_assets.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/widgets/CustomTextField.dart';

import '../../../core/utils/app_color.dart';
import '../../../widgets/check_box.dart';
import '../../../widgets/custom_insurace_type_button.dart';
import '../../../widgets/custom_text_feild/custom_text_from_feild.dart';
import '../../../widgets/toast/enum.dart';
import '../../../widgets/toast/toast.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email=TextEditingController();

  TextEditingController password=TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool hidePassword=true;

  bool isSelected=false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [

          Image.asset(AppAssets.backgroundLogo,fit: BoxFit.cover,width: double.infinity,height: double.infinity,alignment: Alignment.center, ),
          //SvgPicture.asset(AppAssets.gradiant,fit: BoxFit.fill),
          Container(
            width: context.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32,),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                          child: Image.asset(AppAssets.logo,height: 200,width: 200,),
                          tag: 'logo'),
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
                                width: context.width * 0.8,height:
                              context.height * 0.4,
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 8,),
                                        SizedBox( width: context.width*0.6,
                                          child: Text(
                                            maxLines: 2,"welcome Login",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(height: context.height*0.025,),
                                        CustomTextFromField(
                                          backgroundColor: Colors.white,
                                            hintColor: AppColor.primary.withOpacity(0.6),
                                            textInputType: TextInputType.emailAddress,
                                            validator: (value) {

                                              if(value!.isEmpty) {
                                                return '';
                                              }
                                              return null;
                                            },
                                            textEditingController: email, hint:" enter email", label: "email"),
                                        CustomTextFromField(
                                            obscureText: hidePassword,
                                            backgroundColor: Colors.white,
                                            hintColor: AppColor.primary.withOpacity(0.6),
                                            suffixIcon: IconButton(

                                                icon: Icon(hidePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,color:  AppColor.primary.withOpacity(0.6)),
                                                onPressed: (){
                                                  setState(() {
                                                    hidePassword =! hidePassword;
                                                  });
                                                }),
                                            validator: (value){
                                              if(value!.isEmpty)
                                                return '';

                                              return null;
                                            },
                                            textEditingController: password, hint: "enter password", label: "password"),
                                        Row(
                                          children: [
                                            CustomCheckBox(
                                              onTap:  (){
                                                setState(() {
                                                  isSelected=!isSelected;
                                                });
                                              },
                                              size: 24,
                                              isSelected: isSelected,
                                              borderColor:Colors.white,

                                            ),
                                            const SizedBox(width: 4,),
                                            Text("remember me",

                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w500,),
                                            ),
                                            const Spacer(),
                                            Text("forget password",
                                              textAlign: TextAlign.center,
                                              style:TextStyle(fontSize: 14,color: AppColor.primary,fontWeight: FontWeight.w200,),
                                            ),
                                          ],
                                        ),
                                        CustomInsuranceTypeButton(
                                          text: "Login Now",
                                          isLoading: false,
                                          textColor: Colors.white,
                                          buttonColor:AppColor.primary.withOpacity(0.7),

                                          onTap: () async {
                                            if (_formKey.currentState!.validate()){
                                                ToastConfig.showToast(context: context,msg:"Success",
                                                  toastStates: ToastStates.Success,);

                                              }


                                            else {
                                              ToastConfig.showToast(context: context, msg: "please enter required data", toastStates: ToastStates.Error,);
                                            }

                                          },),
                                        SizedBox(height: context.height*0.025,),

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
