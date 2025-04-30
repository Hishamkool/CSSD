import 'package:cssd/util/fonts.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineTileWidget extends StatelessWidget {
  final Widget? endChild;
  final bool isFirst;
  final bool isLast;
  final bool isDone;
  final String endChildTitle;
  final String endChildSubTitle;

  const TimeLineTileWidget({
    super.key,
    this.endChild,
    required this.isFirst,
    required this.isLast,
    required this.isDone,
    required this.endChildTitle,
    required this.endChildSubTitle,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final isMobile = mediaQuery.width <= 500;
    return TimelineTile(
      endChild: endChild ??
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12.0 : 40.0, vertical: 5.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                endChildTitle,
                style: FontStyles.timelineBody,
              ),
              Text(
                endChildSubTitle,
                style: FontStyles.timelineBody,
              ),
            ]),
          ),
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: isDone
          ? LineStyle(color: Colors.green.shade100)
          : const LineStyle(color: Colors.white),
      afterLineStyle: const LineStyle(color: Colors.white),
      indicatorStyle: IndicatorStyle(
        // width: isMobile? 20 : 27,
        width: mediaQuery.width * (20 / 400),
        color:
            isDone ? hexToColorWithOpacity(hexColor: "1EE603") : Colors.white,
        iconStyle:
            IconStyle(iconData: Icons.done, color: Colors.white, fontSize: 20),
      ),
    );
  }
}
