import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  const ExpandableTextWidget(
      {Key? key, required this.text, required this.lengthText})
      : super(key: key);
  final String text;
  final int lengthText;

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > widget.lengthText) {
      firstHalf = widget.text.substring(0, widget.lengthText);
      secondHalf =
          widget.text.substring((widget.lengthText + 1), widget.text.length);
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
              style: Theme.of(context).textTheme.bodyMedium,
            )
          : RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: isExpanded
                        ? firstHalf + secondHalf + ' '
                        : firstHalf + ' ...',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: isExpanded
                        ? "see less"
                        : "see more",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
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
