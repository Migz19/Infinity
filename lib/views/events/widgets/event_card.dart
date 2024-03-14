import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_assets.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/models/event/event_model.dart';
import 'package:infinity/widgets/indictor/custom_indictor.dart';

class EventCard extends StatefulWidget {
  final Color? color;
  final EventModel? event;

  const EventCard({
    Key? key,
    // this.text,
    this.color,
    required this.event,
  }) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 140.0,
      margin: const EdgeInsets.only(
        top: 10.0,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          20.0,
        ),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Expanded(
            flex: 3,
            child: Stack(
              children: [
                widget.event!.filesUrls.isNotEmpty
                    ?  CachedNetworkImage(
              width: context.width,
              height: context.height,
              imageUrl:  widget.event!.filesUrls[0],
              fit: BoxFit.fill,
              progressIndicatorBuilder:
                  (context, url, downloadProgress) => Align(
                alignment: Alignment.bottomCenter,
                child: LinearProgressIndicator(
                  value: downloadProgress.progress,
                  backgroundColor: Colors.grey.shade100,
                ),
              ),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error),
            )
                    : Image.asset(
                        AppAssets.logo,
                      ),
              ],
            ),
          ),
          Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event!.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Spacer(),
                    Text(
                      widget.event!.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          size: 18.0,
                          Icons.location_on_outlined,
                          color: AppColor.primary,
                          // color: AppColors.lightGrey,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Flexible(
                          child: Text(
                            widget.event!.location ?? 'No location',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                              color: AppColor.primary,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          size: 16.0,
                          Icons.timer,
                          color: AppColor.primary,
                          // color: AppColors.lightGrey,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Flexible(
                          child: Text(
                            widget.event!.date,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                              color: AppColor.primary,

                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),

        ],
      ),
    );
  }
}
