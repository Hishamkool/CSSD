class SampleRequest {
  final String requestID;
  final String requestDate;
  final String requestTime;
  final String requestDepartment;
  final String requestSubTitle;
  final String requestTitle;

  SampleRequest({
    required this.requestTime,
    required this.requestID,
    required this.requestDate,
    required this.requestDepartment,
    required this.requestSubTitle,
    required this.requestTitle,
  });
}

//i need list of items with priority,
// requested user,
// status of items ,
// request date and time ,
// request id ,
// departement  name. for timeline

// High Priority Requests
List<SampleRequest> sampleHighPriorityRequestsList = [
  SampleRequest(
    requestID: '1006',
    requestDate: '22/10/2024',
    requestTime: '10:30 am',
    requestDepartment: 'Maternity Ward',
    requestSubTitle: "UMBILICAL CLAMP, DISPOSABLE SCALPEL",
    requestTitle: 'Newborn Delivery Kit',
  ),
  SampleRequest(
    requestID: '1007',
    requestDate: '22/10/2024',
    requestTime: '11:15 am',
    requestDepartment: 'Endoscopy Unit',
    requestSubTitle: "ENDOSCOPE, BIOPSY FORCEPS",
    requestTitle: 'Endoscopy Procedure Tools',
  ),
  SampleRequest(
    requestID: '1008',
    requestDate: '21/10/2024',
    requestTime: '02:45 pm',
    requestDepartment: 'Dental Clinic',
    requestSubTitle: "DENTAL MIRROR, CURETTE, SCALER",
    requestTitle: 'Dental Examination Kit',
  ),
  SampleRequest(
    requestID: '1009',
    requestDate: '20/10/2024',
    requestTime: '03:00 pm',
    requestDepartment: 'Emergency Room',
    requestSubTitle: "IV CANNULA, SYRINGES, TOURNIQUET",
    requestTitle: 'Emergency IV Setup',
  ),
  SampleRequest(
    requestID: '1010',
    requestDate: '20/10/2024',
    requestTime: '01:30 pm',
    requestDepartment: 'Laboratory',
    requestSubTitle: "SLIDE COVERS, MICROSCOPE SLIDES, PIPETTES",
    requestTitle: 'Microscope Preparation Kit',
  ),
  SampleRequest(
    requestID: '1011',
    requestDate: '19/10/2024',
    requestTime: '12:00 pm',
    requestDepartment: 'ICU',
    requestSubTitle: "ENDOTRACHEAL TUBE, AMBU BAG",
    requestTitle: 'Respiratory Emergency Kit',
  ),
  SampleRequest(
    requestID: '1012',
    requestDate: '19/10/2024',
    requestTime: '09:45 am',
    requestDepartment: 'Operation Theater',
    requestSubTitle: "BONE DRILL, SCREWS, SAW BLADE",
    requestTitle: 'Orthopedic Surgery Instruments',
  ),
  SampleRequest(
    requestID: '1013',
    requestDate: '18/10/2024',
    requestTime: '11:30 am',
    requestDepartment: 'Ophthalmology',
    requestSubTitle: "TONOMETER, EYE SPECULUM, FORCEPS",
    requestTitle: 'Eye Examination Tools',
  ),
  SampleRequest(
    requestID: '1014',
    requestDate: '18/10/2024',
    requestTime: '03:15 pm',
    requestDepartment: 'General Surgery',
    requestSubTitle: "LAPAROSCOPE, TROCAR, SCISSORS",
    requestTitle: 'Laparoscopic Surgery Kit',
  ),
  SampleRequest(
    requestID: '1015',
    requestDate: '17/10/2024',
    requestTime: '10:00 am',
    requestDepartment: 'Orthopedics',
    requestSubTitle: "CERVICAL COLLAR, CAST MATERIALS",
    requestTitle: 'Orthopedic Support Items',
  ),
];

// extracting single items from list

List<String> singleItemsList =
    extractSingleItems(sampleHighPriorityRequestsList);
List<String> extractSingleItems(List<SampleRequest> mainList) {
  List<String> items = [];
  for (var item in mainList) {
    items.addAll(item.requestSubTitle.split(',').map((item) => item.trim()));
  }
  return items;
}

// Medium Priority Requests
List<SampleRequest> sampleMediumPriorityRequestsList = [
  SampleRequest(
    requestID: '2001',
    requestDate: '19/10/2024',
    requestTime: '11:00 am',
    requestDepartment: 'Laboratory',
    requestSubTitle: "BIOPSY NEEDLE, SPECIMEN CONTAINER",
    requestTitle: 'Pathology Lab Tools',
  ),
  SampleRequest(
    requestID: '2002',
    requestDate: '18/10/2024',
    requestTime: '03:45 pm',
    requestDepartment: 'Endoscopy',
    requestSubTitle: "ENDOSCOPE BRUSHES, STERILE SYRINGES 5 ML",
    requestTitle: 'Endoscopy Reprocessing',
  ),
  SampleRequest(
    requestID: '2003',
    requestDate: '18/10/2024',
    requestTime: '12:30 pm',
    requestDepartment: 'Dermatology',
    requestSubTitle: "DERMATOME BLADE, STAPLER REMOVER",
    requestTitle: 'Dermatology Minor Procedure Kit',
  ),
];

// Low Priority Requests
List<SampleRequest> sampleLowPriorityRequestsList = [
  SampleRequest(
    requestID: '3001',
    requestDate: '17/10/2024',
    requestTime: '02:00 pm',
    requestDepartment: 'General Surgery',
    requestSubTitle: "SURGICAL CLAMP, HEMOSTAT",
    requestTitle: 'Routine Surgery Instruments',
  ),
  SampleRequest(
    requestID: '3002',
    requestDate: '16/10/2024',
    requestTime: '10:45 am',
    requestDepartment: 'Dental',
    requestSubTitle: "DENTAL MIRROR, STERILE FORCEPS",
    requestTitle: 'Dental Instruments Reprocessing',
  ),
  SampleRequest(
    requestID: '3003',
    requestDate: '16/10/2024',
    requestTime: '03:00 pm',
    requestDepartment: 'Urology',
    requestSubTitle: "CYSTOSCOPE SHEATH, GRASPING FORCEPS",
    requestTitle: 'Urology Procedure Instruments',
  ),
];
