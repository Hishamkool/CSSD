import 'package:cssd/app/modules/Cssd_User/controller/dashboard_controller.dart';
import 'package:cssd/app/modules/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/Department_User/controller/send_to_cssd_controller.dart';
import 'package:cssd/app/modules/Department_User/controller/stock_controller_dept.dart';
import 'package:cssd/app/modules/Department_User/controller/used_item_entry_controller.dart';
import 'package:cssd/app/modules/login_module/controller/login_controller.dart';
import 'package:cssd/app/modules/Cssd_User/controller/pickup_provider.dart';
import 'package:cssd/app/modules/Cssd_User/controller/request_provider.dart';
import 'package:cssd/app/modules/Cssd_User/controller/sterilization_provider.dart';
import 'package:cssd/app/modules/Cssd_User/controller/timeline_provider.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:cssd/util/navigation_observer.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageManager.init();
  runApp(DevicePreview(
    // enabled: !kReleaseMode,
    enabled: false,
    builder: (context) => const MyApp(),
  ));
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // cssd user providers
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => DashboardController()),
        ChangeNotifierProvider(create: (context) => RequestControler()),
        ChangeNotifierProvider(create: (context) => SterilizationProvider()),
        ChangeNotifierProvider(create: (context) => PickupProvider()),
        ChangeNotifierProvider(create: (context) => TimelineController()),
        // department user providers
        ChangeNotifierProvider(create: (context) => SendToCssdControllerCssdCussDeptUser()),
        ChangeNotifierProvider(create: (context) => DashboardControllerCssdCussDeptUser()),
        ChangeNotifierProvider(create: (context) => UsedItemEntryController()),
        ChangeNotifierProvider(create: (context) => StockControllerDepartment()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          //  title: 'Centralized Sterilization and Supply Department',
          title: 'CSSD',
          navigatorObservers: [MyNavigatorObserver()],
          theme: ThemeData(
            primarySwatch: Colors.red, //change later on
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white),
              color: StaticColors.scaffoldBackgroundcolor,
            ),
          ),
          initialRoute: Routes
              .splashScreen, //change the init function inside splash screen view when changing back to splash screen as initial route
          routes: Routes.routes,
        ),
      ),
    );
  }
}




/* 
fast run specific pages
// void main() {
//   runApp(ChangeNotifierProvider(
//       create: (context) => RequestControler(),
//       child: ScreenUtilInit(
//           designSize: const Size(390, 844),
//           minTextAdapt: true,
//           splitScreenMode: true,
//           builder: (context, child) => ())));
// } 
*/