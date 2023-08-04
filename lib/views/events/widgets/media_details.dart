import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_assets.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/widgets/indictor/custom_indictor.dart';

class MediaDetails extends StatefulWidget {
  const MediaDetails({Key? key, required this.images, required this.eventID})
      : super(key: key);
  final List<String> images;
  final int eventID;

  @override
  State<MediaDetails> createState() => _MediaDetailsState();
}

class _MediaDetailsState extends State<MediaDetails> {
  int _selectedImage = 0;
  late List<String> images;
  late int eventID;

  @override
  void initState() {
    super.initState();
    images = widget.images;
    eventID = widget.eventID;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: images.isNotEmpty
          ? Stack(
              children: [
                PageView.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index) => Stack(
                    children: [
                      Hero(
                        child: CachedNetworkImage(
                          imageUrl: '${images[index]}',
                          fit: BoxFit.fitHeight,
                          height: context.height,
                          width: context.width,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Align(
                            alignment: Alignment.bottomCenter,
                            child: LinearProgressIndicator(
                              color: AppColor.primary,
                              value: downloadProgress.progress,
                              backgroundColor: Colors.grey.shade100,
                            ),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Icon(Icons.error),
                          ),
                        ),
                        tag: eventID,
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
                            stops: [0.0, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPageChanged: (index) {
                    setState(() {
                      _selectedImage = index;
                    });
                  },
                ),

                images.length > 1
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 22.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: List.generate(
                              images.length,
                              (index) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 6),
                                child: CustomIndicator(
                                  isSelected: index == _selectedImage,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            )
          : Image.asset(
              AppAssets.logo,
            ),
    );
  }
}
