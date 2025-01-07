import 'package:cssd/app/modules/Department_User/model/used_item_model/used_items_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UsedItemsDataSource extends DataGridSource {
  late List<DataGridRow> _usedItems;
  UsedItemsDataSource({required List<UsedItemsListModelData> usedItemsList}) {
    _usedItems = usedItemsList
        .map((item) => DataGridRow(cells: <DataGridCell>[
              DataGridCell<int>(columnName: "ProductID", value: item.productId),
              DataGridCell<String>(
                  columnName: "ProductName", value: item.productName),
              DataGridCell<int>(columnName: "UQty", value: item.uQty),
              DataGridCell<String>(
                  columnName: "Location", value: item.location),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _usedItems;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
