import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class DynamicSearchField<T> extends StatefulWidget {
  final TextEditingController controller;
  final Future<List<T>> Function(String query) suggestionsCallback;
  final Widget Function(BuildContext context, T suggestion) itemBuilder;
  final void Function(T suggestion) onSelected;
  final String hintText;
  final String? labelText;
  final VoidCallback? onClear;
  final InputDecoration? inputDecoration;
  final VoidCallback? clearDetails;
  final FocusNode? focusNode;

  const DynamicSearchField(
      {super.key,
      required this.controller,
      required this.suggestionsCallback,
      required this.itemBuilder,
      required this.onSelected,
      this.hintText = "Search...",
      this.labelText,
      this.onClear,
      this.clearDetails,
      this.inputDecoration,
      this.focusNode});

  @override
  State<DynamicSearchField<T>> createState() => _DynamicSearchFieldState<T>();
}

class _DynamicSearchFieldState<T> extends State<DynamicSearchField<T>> {
  @override
  Widget build(BuildContext context) {
    return TypeAheadField<T>(
      
      //showOnFocus: false,
      hideOnUnfocus: false,
      focusNode: widget.focusNode,
      controller: widget.controller,
      builder: (context, controller, focusNode) {
        return itemSearchField(context,
            labelText: widget.labelText,
            clearDetails: widget.clearDetails,
            controller: controller,
            focusNode: focusNode,
            hintText: widget.hintText);
      },
      suggestionsCallback: widget.suggestionsCallback,
      itemBuilder: widget.itemBuilder,
      onSelected: widget.onSelected,
      hideOnEmpty: true,
      hideOnError: true,
      hideKeyboardOnDrag: true,
    );
  }
}

itemSearchField(
  BuildContext context, {
  String? hintText,
  String? labelText,
  bool? enabled,
  TextEditingController? controller,
  FocusNode? focusNode,
  TextInputType? textInputType,
  bool? password,
  Color? prefcolor,
  Color? sufcolor,
  Color? borderColor,
  IconData? prefixIcon,
  IconButton? suffixIcon,
  Function? onchange,
  VoidCallback? clearDetails,
}) {
  return InputDecorator(
    decoration:  InputDecoration(
        label: Text("$labelText"), border: InputBorder.none),
    child: TextFormField(
      enabled: enabled,
      obscureText: password ?? false,
      onTapOutside: (event) => focusNode?.unfocus(),
      keyboardType: textInputType,
      controller: controller,
      focusNode: focusNode,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText is empty';
        }
        return null;
      },
      decoration: InputDecoration(
        // labelText: labelText /* ?? 'Search here..' */,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.grey)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        // contentPadding: EdgeInsets.zero,
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        prefixIconColor: Colors.black,
        suffixIcon: IconButton(
            onPressed: () {
              controller?.clear();
              focusNode?.unfocus();
              if (clearDetails != null) {
                clearDetails();
              }
            },
            icon: const Icon(Icons.close)),
        suffixIconColor: sufcolor,
        // disabledBorder: OutlineInputBorder(
        //   borderSide:
        //       const BorderSide(color: Color(0xffE7E7E7)), //<-- SEE HERE
        //   borderRadius: BorderRadius.circular(16.0),
        // ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: borderColor ?? Colors.grey.shade200), //<-- SEE HERE
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffE7E7E7)), //<-- SEE HERE
          borderRadius: BorderRadius.circular(15.0),
        ),
        // errorBorder: OutlineInputBorder(
        //   borderSide:
        //       const BorderSide(color: Color(0xffE7E7E7)), //<-- SEE HERE
        //   borderRadius: BorderRadius.circular(16.0),
        // ),
        // focusedErrorBorder: OutlineInputBorder(
        //   borderSide:
        //       const BorderSide(color: Color(0xffE7E7E7)), //<-- SEE HERE
        //   borderRadius: BorderRadius.circular(16.0),
        // ),
      ),
    ),
  );
}





/*  usage

  DynamicSearchField<Medicines>(
          labelText: "Search medicines",
          clearDetails: () {
            PharmacyBillService().clearPharmacyBillDetails();
            //PharmacyBillService().clearPharmacyForm();
            //genralBill.clearForm();
          },
          hintText: "Eg. Dolo 650 Mg Tablet",
          focusNode: PharmacyBillService().medicineSearchFocus,
          controller: PharmacyBillService().medicineSearchController,
          suggestionsCallback: (query) async {
            // Fetch item suggestions
            if (query.isNotEmpty) {
              return await PharmacyBillService()
                  .medicineSearchForPharmacy(context, query);
            } else {
              return [];
            }
          },
          itemBuilder: (context, product) {
            return ListTile(
              dense: true,
              title:
                  Text("${product.name ?? ""} | ${product.chemicalName ?? ""}"),
              subtitle: Text(
                  "Stock : ${product.cStock ?? ""} | Batch No : ${product.batchNo ?? ""} | Exp : ${product.expiry != null ? DateFormat('dd-MM-yyyy').format(DateTime.parse(product.expiry.toString())) : ""}"),
            );
          },
          onSelected: (product) {
            PharmacyBillService().medicineSearchController.text =
                product.name ?? "";
            PharmacyBillService().rateController.text = product.mrp.toString();
            PharmacyBillService().selectedMedicine = product;
            Log.print(
                "selected medicine from suugestion :::${PharmacyBillService().selectedMedicine}");
            // setState(() {});
          },
        ),

 */