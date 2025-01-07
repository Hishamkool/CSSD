import 'package:cssd/app/modules/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestDetailsTable extends StatelessWidget {
  const RequestDetailsTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<DashboardControllerCssdCussDeptUser>(
          builder: (context, dashboardConsumer, child) {
        if (dashboardConsumer.isLoadingMyRequestDetails == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return FittedBox(
          child: DataTable(
            border: TableBorder(
              bottom: BorderSide(color: Colors.grey.shade300),
            ),
            headingRowColor: const WidgetStatePropertyAll(
                StaticColors.scaffoldBackgroundcolor),
            dataRowMinHeight: 30,
            dataRowMaxHeight: 48.0,
            columnSpacing: 10.0,
            headingTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),

            // border: TableBorder.all(),
            columns: const <DataColumn>[
              DataColumn(label: Text("Sl no.")),
              DataColumn(label: Text("Product ID")),
              DataColumn(label: Text("Product name")),
              DataColumn(label: Text("Quantity")),
            ],
            rows: List<DataRow>.generate(
              dashboardConsumer.itemsWithinRequestList.length,
              (index) {
                final item = dashboardConsumer.itemsWithinRequestList[index];

                return DataRow(
                  cells: [
                    DataCell(Text('${index + 1}')), // Sl
                    DataCell(Text('${item.productId}')), // product id
                    DataCell(Text(item.productName)), // item name
                    DataCell(Text('${item.qty}')), // amount of items requested
                  ],
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
