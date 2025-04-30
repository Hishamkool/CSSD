import 'package:cssd/app/modules/Department_User/controller/used_item_entry_controller.dart';
import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PackageItemsTableWidget extends StatelessWidget {
  final int pkgid;
  const PackageItemsTableWidget({super.key, required this.pkgid});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<UsedItemEntryController>(
          builder: (context, usedItemsConnsumer, child) {
        if (usedItemsConnsumer.islodingPackageItems == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return FittedBox(
          child: DataTable(
            dataRowMinHeight: 30,
            dataRowMaxHeight: 48.0,
            columnSpacing: 10.0,
            headingTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            showCheckboxColumn: true,
            headingRowColor: const WidgetStatePropertyAll(
                StaticColors.scaffoldBackgroundcolor),

            // border: TableBorder.all(),
            columns: const <DataColumn>[
              DataColumn(label: Text("Sl no.")),
              DataColumn(label: Text("ID")),
              DataColumn(label: Text("Product_Name")),
              DataColumn(label: Text("Qty")),
            ],

            rows: List<DataRow>.generate(
              usedItemsConnsumer.packageItemsList.length,
              (index) {
                final item = usedItemsConnsumer.packageItemsList[index];

                return DataRow(
                  cells: [
                    DataCell(
                      Text('${index + 1}'),
                    ), // Sl
                    DataCell(Text('${item.id}')),
                    DataCell(Text(item.productName)),
                    DataCell(
                      Text('${item.pckQty}'),
                    ),
                  ],
                  onSelectChanged: (value) {},
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
