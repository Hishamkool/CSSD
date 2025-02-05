import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/Widgets/typehead_dropdown_search.dart';
import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';

class StockEntryDepartmentView extends StatelessWidget {
  StockEntryDepartmentView({super.key});

  final TextEditingController itemsSearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const space = const SizedBox(
              height: 10,
            );
    return Scaffold(
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
              controller: itemsSearchController,
              suggestionsCallback: (query) async {
                if (query.isNotEmpty) {
                  return [];
                } else {
                  return [];
                }
              },
              itemBuilder: (context, product) {
                return ListTile(
                  dense: true,
                  title: Text(product.processName),
                  subtitle: Text("pressuer : ${product.pressure} "),
                );
              },
              onSelected: (process) {},
            ),
            space,
            DropdownButtonFormField<String>(
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
           space,
            CustomTextFormField(
              textFieldSize: Size(40, 50),
            )
          ],
        ),
      ),
    );
  }
}
