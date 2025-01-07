import 'package:cssd/app/modules/Cssd_User/model/sampleBatchNoQuantity.dart';
import 'package:cssd/app/modules/Cssd_User/model/sampleRequestList.dart';
import 'package:cssd/util/fonts.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SterilizationPackageItemsPopupWidget extends StatelessWidget {
  const SterilizationPackageItemsPopupWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: sampleHighPriorityRequestsList.length,
      itemBuilder: (context, index) {
        final request = sampleHighPriorityRequestsList[index];
        final quantity = SampleGeneratedList().sampleQuantityList[index];
        final batch = SampleGeneratedList().sampleBatchNo[index];
        return Card(
          color: hexToColorWithOpacity(hexColor: 'EBF9FF'),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment : CrossAxisAlignment.start,
              children: [
                Text(request.requestTitle,style: FontStyles.bodyPieTitleStyle,),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Checkbox(
                        value: true,
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      flex: 6,
                      child: Text(request.requestSubTitle),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                              'Batch no. : $batch',
                            ),
                          ),
                          SizedBox(
                            height: 9.0.h,
                          ),
                          FittedBox(
                            child: Text(
                              'Quantity : $quantity',
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
