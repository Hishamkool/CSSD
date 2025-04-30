import 'package:flutter/material.dart';

class PickupProvider extends ChangeNotifier {
  TextEditingController departmentSelection = TextEditingController();
  TextEditingController fromDateTextController = TextEditingController();
  TextEditingController toDateTextController = TextEditingController();

  final List<String> _sampleDepartmentName = [
    "Cardiology",
    "Neurology",
    "Pediatrics",
    "	Obstetrics and Gynecology",
    "Oncology",
    "Orthopedics",
    "Radiology",
    "Pathology",
    "General Surgery"
    "Urology",
    "Dermatology",
    "Gastroenterology",
    "Nephrology",
    "Pulmonology",
    "Psychiatry",
  ];

  List<String> get sampleDepartmentName => _sampleDepartmentName;
}
