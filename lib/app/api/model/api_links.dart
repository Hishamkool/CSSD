class ApiLinks{

  static const String baseIp = "http://192.168.0.251:65113/api/" ; 

  //login
  static const String preLoginAuth = "Home/PreLoginAuthentication";
  static const String login = "Home/Login";
  
  //cssd user
  static const String getCssdList = "/Home/GetCSSD_List"; // cssd dashboard request list 
  static const String getCssdDet = "/Home/GetCSSD_Det";  // cssd dashboard request list details
  static const String acceptRequest = "/Home/AcceptRequest";  // cssd dashboard accepting the whole request using requestId
  static const String getMachineName = "/Home/GetMachineName"; // to get machine names for sterilization
  static const String getProcessName = "/Home/GetProcessName";  // to get the sterilization process names with queery for dropdown
  static const String getAcceptedItemList = "/Home/GetAcceptedItem_List"; // to get items for sterilization page items search


  //department user
  static const String departementList = 'Department/DepartmentList';  //departments in the hospital
  static const String getItemName = 'Department/GetItemName'; //items under a particular department
  static const String getRequestedCount = 'Department/GetRequestedCount';  //department pie chart 
  static const String getRequestDetails = 'Department/GetRequested_Details'; 
  static const String getPendingRequestCount = 'Department/GetPendingRequestCount'; //department pie chart 
  static const String getPendingRequestdetails = 'Department/GetPendingRequestdetails'; 
  static const String getDepartmentwiseStockDetails = 'Department/GetDepartmentwiseStock_Details'; // stock for each department
  static const String qtyValidation = 'Department/QtyValidation'; // amount of valid quantity while doing used item entry
  static const String usedItemEntry = 'Department/UsedItemEntry';  // to post used items
  static const String getUsedItemNames = 'Department/GetUsedItemNames';  // for search suggessions of used items list 
  static const String sendToCssd = 'Department/SendToCssd';  // to send items to cssd for sterilization
  static const String departmentwiseUsedItemList = 'Department/Departmentwise_UsedItemList';  // to get saved used items list for a particular department
  static const String getCssdSentItems = 'Department/GetCssdSentItems';  // to display my requests on department dashboard
  static const String getCssdSentItemDetails = 'Department/GetCssdSentItem_Details';  // to display my requests details containing items within a request on department dashboard
  static const String getPackagedetails = 'Department/GetPackagedetails';  // to get items within a package to add to used items list 
  
}


