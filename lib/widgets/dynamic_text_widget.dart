import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_color.dart';

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
    return Container(
      child: secondHalf.isEmpty
          ? Text(
              firstHalf,
              style:TextStyle(fontSize: 22),
            )
          : RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: isExpanded
                        ? '$firstHalf$secondHalf '
                        : '$firstHalf ...',
                    style: TextStyle(color: AppColor.tertiary,fontSize: 20,letterSpacing: 1.01 ,),
                  ),
                  TextSpan(
                    text: isExpanded
                        ? "see less"
                        : "see more",
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(
                          () {
                            isExpanded = !isExpanded;
                          },
                        );
                      },
                  ),
                ],
              ),
            ),
    );
  }
}
