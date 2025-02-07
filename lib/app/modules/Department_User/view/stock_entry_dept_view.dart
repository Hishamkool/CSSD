import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/Widgets/typehead_dropdown_search.dart';
import 'package:cssd/app/modules/Department_User/controller/stock_controller_dept.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockEntryDepartmentView extends StatelessWidget {
  const StockEntryDepartmentView({super.key});

  @override
  Widget build(BuildContext context) {
    final stockController =
        Provider.of<StockControllerDepartment>(context, listen: false);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () {},
          child: const Text("Save"),
        ),
      ),
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("Stock Entry"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: Colors.white,
        ),
        child: ListView(
          children: [
            DynamicSearchField(
              labelText: "Item name",
              clearDetails: () {},
              hintText: "Search items from store",
              controller: stockController.itemsSearchController,
              suggestionsCallback: (query) async {
                if (query.isNotEmpty) {
                  return [];
                } else {
                  return [];
                }
              },
              itemBuilder: (context, product) {
                return Container(
                  color: Colors.amber.shade50,
                  child: Column(
                    children: [
                      Text(product.processName),
                      Text("pressuer : ${product.pressure} "),
                    ],
                  ),
                  /*   dense: true,
                  title: Text(product.processName),
                  subtitle: Text("pressuer : ${product.pressure} "), */
                );
              },
              onSelected: (process) {},
            ),
            spaceH(5),
            DropdownButtonFormField<String>(
              dropdownColor: Colors.amber.shade50,
              decoration: const InputDecoration(
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide:
                      BorderSide(color: StaticColors.lightContainerborder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide:
                      BorderSide(color: StaticColors.lightContainerborder),
                ),
                labelText: "Category",
              ),
              items: const [
                DropdownMenuItem(value: "Reusable", child: Text("Reusable")),
                DropdownMenuItem(
                    value: "Disposable", child: Text("Disposable")),
              ],
              onChanged: (value) {
                // Handle selection
              },
            ),
            spaceH(12),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.end,
              runAlignment: WrapAlignment.spaceBetween,
              runSpacing: 10,
              direction: Axis.horizontal,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2.2),
                  child: CustomTextFormField(
                    controller: stockController.sterilizedQuantityCntrl,
                    hintStyle: TextStyle(color: Colors.grey.shade300),
                    useLabel: true,
                    hintText: "24",
                    label: const FittedBox(
                        child: Text(
                      "Sterilized Quantity",
                    )),
                    keyboardType: TextInputType.number,
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2.2),
                  // width: MediaQuery.of(context).size.width / 2 ,
                  child: CustomTextFormField(
                    controller: stockController.unsterilizedQuantityCntrl,
                    useLabel: true,
                    hintText: "15",
                    hintStyle: TextStyle(color: Colors.grey.shade300),
                    label: const FittedBox(
                        child: Text(
                      "Unsterilized Quantity",
                    )),
                    keyboardType: TextInputType.number,
                  ),
                ),
                InputDecorator(
                  decoration: const InputDecoration(
                      isDense: true,
                      constraints: BoxConstraints(maxWidth: 150),
                      border: InputBorder.none,
                      label: Text("Total items Count:")),
                  child: Consumer<StockControllerDepartment>(
                      builder: (context, stockProvider, child) {
                    final sterilizedQuantity = int.tryParse(
                            stockProvider.sterilizedQuantityCntrl.text) ??
                        0;
                    final unsterilizedQuantity = int.tryParse(
                            stockProvider.unsterilizedQuantityCntrl.text) ??
                        0;
                    return Text("${sterilizedQuantity + unsterilizedQuantity}");
                  }),
                ),
                // button to add items to the list
                ButtonWidget(
                  onPressed: () {},
                  buttonLabel: "Add Item",
                ),
              ],
            ),

            // listing items
            ListView.separated(
              separatorBuilder: (context, index) => spaceH(10),
              padding: const EdgeInsets.symmetric(vertical: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 22,
              itemBuilder: (context, index) {
                // temperary variable replace this condition with the category of the item (reusable or disposable)

                return Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: StaticColors.lightBgContainer,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            child: Text(
                              "1",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(
                            "BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM ",
                            softWrap: true,
                            style: TextStyle(fontSize: 13),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Stock : 25"),
                              Text("Type : CSSD"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: index == 0 ? Colors.green : Colors.red),
                            child: index == 0
                                ? const Row(
                                    children: [
                                      Icon(
                                        Icons.recycling,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        "Reusable",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Row(
                                    children: [
                                      Icon(
                                        FluentIcons.bin_recycle_20_filled,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        "Disposable",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )))
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
