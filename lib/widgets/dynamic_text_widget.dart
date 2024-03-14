import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/widgets/toast/enum.dart';
import 'package:infinity/widgets/toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class DynamicTextWidget extends StatefulWidget {
  const DynamicTextWidget(
      {Key? key, required this.text, required this.length})
      : super(key: key);
  final String text;
  final int length;

  @override
  State<DynamicTextWidget> createState() => _DynamicTextWidgetState();
}

class _DynamicTextWidgetState extends State<DynamicTextWidget> {
  late String firstHalf;
  late String secondHalf;
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > widget.length) {
      firstHalf = widget.text.substring(0, widget.length);
      secondHalf =
          widget.text.substring((widget.length + 1), widget.text.length);
      isExpanded = false;
    } else {
      firstHalf = widget.text;
      secondHalf = '';
      isExpanded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: secondHalf.isEmpty
              ? Linkify(
                text: firstHalf,
                style:const TextStyle(fontSize: 22),
                onOpen: (link) async {
                 if (await canLaunch(link.url)) {
                await launch(link.url);
              } else {
                ToastConfig.showToast(context: context,
                    msg: 'Could not launch $link', toastStates: ToastStates.Warning);
              }
            },
                )
              :



          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Linkify(
                onOpen: (link) async {

                  print("Link : ${link.url}");
                  if (await canLaunch(link.url)) {
                    await launch(link.url);
                    
                  } else {
                    ToastConfig.showToast(context: context,
                        msg: 'Could not launch $link', toastStates: ToastStates.Warning);
                  }
                },
               text: isExpanded
                    ? '$firstHalf$secondHalf '
                    : '$firstHalf ...',
                style: TextStyle(color: AppColor.tertiary,fontSize: 20,letterSpacing: 1.01 ,),
                linkStyle: const TextStyle(color: Colors.blue,
                    decoration: TextDecoration.underline),
              ),
              const SizedBox(height: 2),
              GestureDetector(
                onTap: () {
                  setState(
                        () {
                      isExpanded = !isExpanded;
                    },
                  );
                },
                child: Text(
                   isExpanded
                      ? "see less"
                      : "see more",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.blue,
                  ),

                ),
              ),
            ],
          ),
        ),
        const Linkify(
          text: '',),
      ],
    );
  }
}
