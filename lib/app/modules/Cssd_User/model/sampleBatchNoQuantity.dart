import 'dart:math';

import 'package:cssd/app/modules/Cssd_User/model/sampleRequestList.dart';

class SampleGeneratedList {
  List<String> sampleBatchNo =
      List.generate(sampleHighPriorityRequestsList.length, (index) {
    final Random random = Random();
    return "${random.nextInt(2314) + 20}";
  });

  List<int> sampleQuantityList =
      List.generate(sampleHighPriorityRequestsList.length, (index) {
    final Random random = Random();
    return random.nextInt(10) + 5;
  });

  List<int> sampleRequestNumber =
      List.generate(sampleHighPriorityRequestsList.length, (index) {
    final Random random = Random();
    return random.nextInt(1000) + 1;
  });
}
