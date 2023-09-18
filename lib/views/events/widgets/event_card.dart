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
    final _event = widget.event;
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
                _event!.filesUrls.isNotEmpty
                    ? PageView.builder(
                        onPageChanged: (index) => setState(() {
                          _selectedIndex = index;
                        }),
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              CachedNetworkImage(
                                width: context.width,
                                height: context.height,
                                imageUrl: _event.filesUrls[index],
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
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  gradient: LinearGradient(
                                    begin: FractionalOffset.topCenter,
                                    end: FractionalOffset.bottomCenter,
                                    colors: [
                                      Colors.grey.withOpacity(0.0),
                                      Colors.black,
                                    ],
                                    stops: const [0.0, 1.0],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: _event.filesUrls.length,
                      )
                    : Image.asset(
                        AppAssets.logo,
                      ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _event.filesUrls.length < 2
                            ? 0
                            : _event.filesUrls.length,
                        (index) => CustomIndicator(
                          isSelected: index == _selectedIndex,
                          size: 10.0,
                        ),
                      ),
                    ),
                  ),
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
                      _event.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      _event.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 14.0, color: Colors.black),
                    ),
                    // const SizedBox(
                    //   height: 8.0,
                    // ),
                    Spacer(),
                    Text(
                      _event.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 12.0,
                          ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                size: 16.0,
                                Icons.location_on_outlined,
                                // color: AppColors.lightGrey,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Flexible(
                                child: Text(
                                  _event.location ?? 'No location',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 12.0,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                size: 16.0,
                                Icons.timelapse,
                                // color: AppColors.lightGrey,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Flexible(
                                child: Text(
                                  _event.date,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 10.0,
                                      ),
                                ),
                              ),
                            ],
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
