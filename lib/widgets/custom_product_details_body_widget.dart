import 'package:flutter/material.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/utils/styles.dart';

import 'package:open_cart/widgets/custom_history_text_widget.dart';
import 'package:open_cart/widgets/food_image_widget_large.dart';
import 'package:open_cart/widgets/food_rating_and_prep_time_widget.dart';
import 'package:open_cart/widgets/is_veg_badge_widget.dart';
class CustomProductDetailsBodyWidget extends StatelessWidget {
  final Size deviceSize;
  final Map map;
  const CustomProductDetailsBodyWidget(
      {Key? key, required this.deviceSize, required this.map})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FoodImageWidget(deviceSize: deviceSize, map: map),
          const SBH30(),
          Text(
            map["foodName"],
            style: tsCOrangeCustomFFPrimaryS30,
          ),
          const SBH20(),
          Row(
            children: [
              IsVegBadgeWidget(
                map: map,
              ),
              const SBW20(),
              FoodRatingAndPrepTimeWidget(
                map: map,
              )
            ],
          ),
          const SBH20(),
          Text(
            map['foodDetails'],
            style: tsCwhiteS15W300,
          ),
          const SBH20(),
          Text(
            '${map['foodprice'].toString()} ₹',
            style: tsCwhiteS30W800,
          ),
          const SBH20(),
          const CustomHistorytextWidget()
        ],
      ),
    );
  }
}
