import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/controller/dashboard_controller.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/sterilization_controller.dart';
import 'package:cssd/app/modules/login_module/controller/login_provider.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/controller/pickup_provider.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/controller/request_controler.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/controller/sterilization_provider.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/controller/timeline_controller.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:cssd/util/navigation_observer.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageManager.init();
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(),
  ));
}

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
          ChangeNotifierProvider(create: (context) => SterilizationControllerCssdCussDeptUser()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
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
          initialRoute: Routes.loginScreen,
          
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