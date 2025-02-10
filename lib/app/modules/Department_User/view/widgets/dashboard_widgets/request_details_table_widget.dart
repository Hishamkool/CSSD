import 'package:cssd/app/modules/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RequestDetailsTable extends StatefulWidget {
  const RequestDetailsTable({
    super.key,
  });

  @override
  State<RequestDetailsTable> createState() => _RequestDetailsTableState();
}

class _RequestDetailsTableState extends State<RequestDetailsTable> {
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _verticalScrollController,
      scrollDirection: Axis.vertical,
      child: Scrollbar(
        controller: _verticalScrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _horizontalScrollController,
          scrollDirection: Axis.horizontal,
          child: Consumer<DashboardControllerCssdCussDeptUser>(
              builder: (context, dashboardConsumer, child) {
            if (dashboardConsumer.isLoadingMyRequestDetails == true) {
              return Center(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child:
                        LottieBuilder.asset("assets/lottie/loading dots.json")),
              );
            }
            return DataTable(
              border: TableBorder(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
              dataRowColor: const WidgetStatePropertyAll(Colors.white),
              headingRowColor: const WidgetStatePropertyAll(
                  StaticColors.scaffoldBackgroundcolor),
              dataRowMinHeight: 30,
              dataRowMaxHeight: 48.0,
              columnSpacing: 10.0,
              headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),

              // border: TableBorder.all(),
              columns: const <DataColumn>[
                DataColumn(
                    label: Text("Sl no."),
                    headingRowAlignment: MainAxisAlignment.center,
                    numeric: true),
                DataColumn(
                    label: Text("Quantity"),
                    headingRowAlignment: MainAxisAlignment.center,
                    numeric: true),
                DataColumn(
                    label: Text("Product name"),
                    headingRowAlignment: MainAxisAlignment.center),
                DataColumn(
                    label: Text("Product ID"),
                    headingRowAlignment: MainAxisAlignment.center,
                    numeric: true),
              ],
              rows: List<DataRow>.generate(
                dashboardConsumer.itemsWithinRequestList.length,
                (index) {
                  final item = dashboardConsumer.itemsWithinRequestList[index];

                  return DataRow(
                    cells: [
                      DataCell(Center(child: Text('${index + 1}'))), // Sl
                      DataCell(Center(
                        child: Text(
                          '${item.qty}',
                        ),
                      )), // amount of items requested
                      DataCell(Text(item.productName)), // item name
                      DataCell(Center(
                        child: Text('${item.productId}',
                            textAlign: TextAlign.center),
                      )), // product id
                    ],
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
