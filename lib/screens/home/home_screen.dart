import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:webfeed/webfeed.dart';

import '../../constants/icons.dart';
import '../../controllers/webfeed_controller.dart';
import '../../responsive.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home_screen';
  final webFeedController = Get.find<WebFeedController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Responsive(
            mobile: Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Novinarko',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SvgPicture.asset(
                        MyIcons.menu,
                        height: 32.r,
                        width: 32.r,
                      ),
                    ],
                  ),
                  Expanded(
                    child: webFeedController.obx(
                      (rssFeed) => ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: rssFeed!.items!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final RssItem feed = rssFeed.items![index];

                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: feed.enclosure?.url ?? feed.content!.images.first,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  feed.title ?? 'no title',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
