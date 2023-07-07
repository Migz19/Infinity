import 'dart:isolate';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/models/event/event_model.dart';
import 'package:infinity/views/events/widgets/media_details.dart';
import 'package:infinity/widgets/expandable_text_widget.dart';
import 'package:infinity/widgets/naviagtion.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({Key? key, required this.event})
      : super(key: key);
  final EventModel event;

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  late EventModel _event;



  @override
  void initState() {
    super.initState();
    _event = widget.event;
  }

  static String? taskId;


  @override
  Widget build(BuildContext context) {
    print('service details screen build');
    // print('service saved1: ${_serviceSet.saved}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,

        title:  Text(
          "Event Details",
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: context.height * 0.4,
            leading: Container(),
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: MediaDetails(
                images: _event.images!,
                //todo nour add event id
                eventID: 0,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      _event.title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpandableTextWidget(
                          lengthText: 150,
                          //todo add to localization
                          text: _event.description ?? 'No Description',
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Expanded(
                              child: Text(
                                _event.location ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.timelapse,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Expanded(
                              child: Text(
                                timeago.format(
                                  DateTime.parse(_event.date!),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class CustomPopMenuButton extends StatelessWidget {
//   const CustomPopMenuButton({Key? key, required this.event})
//       : super(key: key);
//   final EventModel event;
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<HomeProvider>(
//       builder: (context, provider, child) {
//         if (provider.saved[event.id] == null&&event.senderId !=
//             Provider.of<LoginProvider>(context).userResponse!.id) {
//           print('service saved2: ${event.saved}');
//           print('service id: ${event.id}');
//           context.read<HomeProvider>().setSaved(event.id!, event.saved!);
//           print(
//               'service id:${event.id} saved value from provider: ${context.read<HomeProvider>().saved[event.id]}');
//         }
//         return event.senderId ==
//                 Provider.of<LoginProvider>(context).userResponse!.id
//             ? PopupMenuButton<String>(
//                 onSelected: (value) async {
//                   if (value == 'edit') {
//                     AppNavigator.customNavigator(
//                       context: context,
//                       screen: UpdateService(event: event),
//                       finish: false,
//                     );
//                   } else if (value == 'delete') {
//                     buildDialog(context);
//                   }
//                 },
//                 color: Theme.of(context).cardColor,
//                 icon: Icon(
//                   Icons.more_horiz,
//                   color: Theme.of(context).iconTheme.color,
//                 ),
//                 itemBuilder: (context) => [
//                   popupMenuItem(
//                     value: 'edit',
//                     color: Theme.of(context).iconTheme.color,
//                     title: AppLocalizations.of(context)!.edit,
//                     iconData: IconlyBroken.edit,
//                   ),
//                   if (event.senderId !=
//                       context.read<LoginProvider>().userResponse!.id)
//                     PopupMenuDivider(),
//                   popupMenuItem(
//                     value: 'delete',
//                     color: Colors.red,
//                     title: AppLocalizations.of(context)!.delete,
//                     iconData: IconlyBroken.delete,
//                   )
//                 ],
//               )
//             : PopupMenuButton<String>(
//                 onSelected: (value) async {
//                   if (value == 'report') {
//                     showModalBottomSheet(
//                       context: context,
//                       isScrollControlled: true,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20.0),
//                           topRight: Radius.circular(20.0),
//                         ),
//                       ),
//                       builder: (context) => Padding(
//                         padding: EdgeInsets.only(
//                             bottom: MediaQuery.of(context).viewInsets.bottom),
//                         child: ReportBottomSheet(eventID: event.id!),
//                       ),
//                     );
//                   } else if (value == 'save') {
//                     // print('on save function');
//                     if (provider.saved[event.id]!) {
//                       try {
//                         await provider.removeBookmark(
//                           eventID: event.id!,
//                           userId:
//                               context.read<LoginProvider>().userResponse!.id,
//                         );
//                       } on UnauthorisedException {
//                         ToastConfig.showToast(
//                           context: context,
//                           msg: AppLocalizations.of(context)!.authError,
//                           toastStates: ToastStates.Error,
//                         );
//                       } on DataNotFoundException {
//                         ToastConfig.showToast(
//                           context: context,
//                           msg: AppLocalizations.of(context)!.notFound,
//                           toastStates: ToastStates.Error,
//                         );
//                       }
//                     } else {
//                       await provider.addBookmark(
//                         eventID: event.id!,
//                         userId: context.read<LoginProvider>().userResponse!.id,
//                       );
//                     }
//                     // print('saved');
//                   }
//                 },
//                 color: Theme.of(context).cardColor,
//                 icon: Icon(
//                   Icons.more_horiz,
//                   color: Theme.of(context).iconTheme.color,
//                 ),
//                 itemBuilder: (context) => [
//                   popupMenuItem(
//                     value: 'save',
//                     color: provider.saved[event.id]!
//                         ? Colors.red
//                         : Theme.of(context).iconTheme.color,
//                     title: provider.saved[event.id]!
//                         ? AppLocalizations.of(context)!.unSaveThisService
//                         : AppLocalizations.of(context)!.saveThisService,
//                     iconData: provider.saved[event.id]!
//                         ? IconlyBroken.delete
//                         : Icons.bookmark_border,
//                   ),
//                   if (event.senderId !=
//                       context.read<LoginProvider>().userResponse!.id)
//                     PopupMenuDivider(),
//                   if (event.senderId !=
//                       context.read<LoginProvider>().userResponse!.id)
//                     popupMenuItem(
//                       value: 'report',
//                       color: Theme.of(context).iconTheme.color,
//                       title: AppLocalizations.of(context)!.reportThisService,
//                       iconData: Icons.not_interested,
//                     )
//                 ],
//               );
//       },
//     );
//   }
//
//   PopupMenuItem<String> popupMenuItem({
//     required String value,
//     required String title,
//     required IconData iconData,
//     Color? color,
//   }) =>
//       PopupMenuItem(
//         value: value,
//         child: Row(
//           children: [
//             Icon(
//               iconData,
//               color: color,
//             ),
//             const SizedBox(
//               width: 10.0,
//             ),
//             Text(
//               title,
//               style: TextStyle(color: color),
//             ),
//           ],
//         ),
//       );
//
//   void buildDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 AppLocalizations.of(context)!.confirmDelete,
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: MaterialButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         color: Colors.grey.shade600,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         child: Text(
//                           AppLocalizations.of(context)!.cancel,
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 8.0,
//                   ),
//                   Expanded(
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: MaterialButton(
//                         onPressed: () async {
//                           try {
//                             await context
//                                 .read<AddServiceProvider>()
//                                 .deleteService(
//                                   serviceID: event.id.toString(),
//                                   userId: context
//                                       .read<LoginProvider>()
//                                       .userResponse!
//                                       .id
//                                       .toString(),
//                                 )
//                                 .then((value) {
//                               int count = 0;
//                               // Navigator.pop(context);
//                               Navigator.of(context)
//                                   .popUntil((route) => count++ >= 2);
//                               ToastConfig.showToast(
//                                 context: context,
//                                 msg: AppLocalizations.of(context)!
//                                     .deleteServicesSuccessfully,
//                                 toastStates: ToastStates.Success,
//                               );
//                             });
//                           } on BadRequestException {
//                             ToastConfig.showToast(
//                               context: context,
//                                 msg: AppLocalizations.of(context)!
//                                     .canNotDeleteAcceptedService,
//                                 toastStates: ToastStates.Error);
//                           } catch (error) {
//                             ToastConfig.showToast(
//                               context: context,
//                                 msg: AppLocalizations.of(context)!.authError,
//                                 toastStates: ToastStates.Error);
//                           }
//                         },
//                         color: Colors.red,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         child: Text(
//                           AppLocalizations.of(context)!.delete,
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//       //control if we click outside alert dialog.
//       // barrierDismissible: false,
//       // barrierColor: Colors.deepOrange.withOpacity(.3),
//     );
//   }
// }
