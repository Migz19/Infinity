import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinity/core/utils/app_assets.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/provider/navigator/navigator_provider.dart';
import 'package:infinity/views/committees/details_committess_screen.dart';
import 'package:infinity/views/committees/model/committee_model.dart';
import 'package:infinity/views/committees/providers/committee_details_provider.dart';
import 'package:infinity/views/committees/widgets/committee_card.dart';
import 'package:infinity/widgets/naviagtion.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/app_constants.dart';

class CommitteeScreen extends StatelessWidget {
  // Function to launch the Facebook app or open in browser
  void _launchFacebook() async {
    const facebookUrl = 'https://www.facebook.com/infinityclub13'; // Replace with your Facebook URL

    if (await canLaunch(facebookUrl)) {
      await launch(facebookUrl);
    } else {
      throw 'Could not launch $facebookUrl';
    }
  }
  void _launchInstagram() async {
    const facebookUrl = 'https://www.instagram.com/infinity.club.asu/'; // Replace with your Facebook URL

    if (await canLaunch(facebookUrl)) {
      await launch(facebookUrl);
    } else {
      throw 'Could not launch $facebookUrl';
    }
  }
  void _launchTiktok() async {
    const facebookUrl = 'https://www.tiktok.com/@infinityclubasu?_t=8iMkCHYKVLJ&_r=1'; // Replace with your Facebook URL

    if (await canLaunch(facebookUrl)) {
      await launch(facebookUrl);
    } else {
      throw 'Could not launch $facebookUrl';
    }
  }
  void _launchThread() async {
    const facebookUrl = 'https://www.threads.net/@infinity.club.asu'; // Replace with your Facebook URL

    if (await canLaunch(facebookUrl)) {
      await launch(facebookUrl);
    } else {
      throw 'Could not launch $facebookUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black38,
        title: Text(
          context
              .watch<NavigatorProvider>()
              .screenTitles[context.read<NavigatorProvider>().currentIndex],
          textAlign: TextAlign.start,
          style:
          TextStyle(fontWeight: FontWeight.w500, color: AppColor.primary),
        ),
        toolbarHeight: context.height * 0.08,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Image.asset(
              AppAssets.logo,
              width: 100,
              height: 100,
              alignment: Alignment.topRight,
            ),
          ),
        ],
        elevation: 3,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<void>(
        future: getCommitteesDetails(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
                child: Column(
                  children: [
                    GridView.count(
                      crossAxisCount: 3,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 20,
                      shrinkWrap: true,
                      children:context.read<CommitteeDetailsProvider>().committeesList
                          .map(
                            (data) => GestureDetector(
                              child:
                                  CustomCard(data.name, data.photoUri, true),
                              onTap: () {
                                AppNavigator.customNavigator(
                                    context: context,
                                    screen: CommitteeDetailsScreen(
                                      committeeModel: data,
                                    ),
                                    finish: false);
                              },
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(
                       height: 18,
                     ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         const Expanded(child:  Divider(color
                            : Colors.grey,thickness: 1.2,height: 2)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Contact Us",
                            textAlign: TextAlign.center,style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500,color:
                            AppColor.primary),),
                        ),
                        const Expanded(child:
                        Divider(color: Colors.grey,thickness: 1.2,height: 2)),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                     Row(
                      children: [

                         Expanded(
                           child: GestureDetector(
                             onTap: _launchFacebook,
                             child: Container(
                               decoration: BoxDecoration(
                                 color: Colors.blue.withOpacity(0.2),
                                 borderRadius: BorderRadius.circular(15),
                               ),
                               padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 18),
                               child: const Column(
                                 children: [
                                   Icon(Icons.facebook,color: Colors.blue,size: 30),
                                   Text("FaceBook",style: TextStyle(
                                     color: Colors.blue,
                                     fontSize: 12,fontWeight: FontWeight.w400,
                                   ),)
                                 ],
                               ),
                             ),
                           ),
                         ),
                         const SizedBox(width: 8,),
                        Expanded(
                          child: GestureDetector(
                            onTap: _launchThread,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding:const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                              child: Column(
                                children: [
                                  Image.asset(
                                    height: 30,
                                    width: 40,
                                    AppAssets.ThreadIcon,
                                  ),
                                  const Text("Thread",style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,fontWeight: FontWeight.w400,
                                  ),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8,),
                         Expanded(


                           child: GestureDetector(
                             onTap: _launchInstagram,
                             child: Container(
                              decoration: BoxDecoration(
                                color: Colors.pink.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                              child: Column(
                                children: [
                                  Image.asset(
                                      height: 30,
                                      width: 30,
                                      AppAssets.instragramIcon,
                                  ),
                                  const Text("Instragram",style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 12,fontWeight: FontWeight.w400,
                                  ),)
                                ],
                              ),
                                                     ),
                           ),
                         ),
                        const SizedBox(width: 8,),
                         Expanded(
                           child: GestureDetector(
                             onTap: _launchTiktok,
                             child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding:const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                              child: Column(
                                children: [
                                  Image.asset(
                                    height: 30,
                                    width: 30,
                                    AppAssets.tiktokIcon,
                                  ),
                                  const Text("TikTok ",style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,fontWeight: FontWeight.w400,
                                  ),)
                                ],
                              ),
                                                     ),
                           ),
                         ),


                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                   GestureDetector(
                     onTap: (){
                       showDialog(
                         context: context,
                         builder: (BuildContext context) {
                           return AlertDialog(
                             icon:const Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                  Text('Infinity QR Code Scan',
                                  style: TextStyle(fontWeight: FontWeight.w600)),
                               ],
                             ),
                             // title:
                              content: Image.asset
                                (AppAssets.QRCodeImage,height: 140,width: 140),

                            actionsAlignment: MainAxisAlignment.center,
                             actions: [
                               TextButton(
                                 onPressed: () {
                                   Navigator.of(context).pop(); // Close the dialog
                                 },
                                 child: const Text('Close',
                                     style: TextStyle(
                                      // color: AppColor.primary,
                                       color: Colors.black,
                                       fontSize: 18,
                                       fontWeight: FontWeight.w500,
                                     )),
                               ),
                             ],
                           );
                         },
                       );
                     },
                     child: const   Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(Icons.qr_code_2,),
                           Text("QR Code Scan Now",
                           style: TextStyle(
                               fontWeight: FontWeight.w600,
                               fontSize: 16,
                               decoration: TextDecoration.underline )),
                         ],
                       ),
                   ),
                  ],
                ),
              );
            } else  {
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
          }
          else {
            return Center(
              child: CircularProgressIndicator(color: AppColor.primary),
            );
          }
        },

      ),
    );
  }

  Future<List<CommitteeModel>> getCommitteesDetails(BuildContext context) async {
   return await context
        .read<CommitteeDetailsProvider>()
        .getCommitteesList();
  }
}
