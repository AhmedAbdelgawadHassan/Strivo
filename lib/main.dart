import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strivo/core/routing/app_routers.dart';
import 'package:strivo/core/services/shared_preferences_singleton.dart';
import 'package:strivo/core/utils/app_colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Prefs.init();
  runApp(DevicePreview(enabled: false, builder: (context) => const Strivo()));
}

class Strivo extends StatelessWidget {
  const Strivo({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(  /// package for responsive design
        designSize: const Size(375, 812),  // size of the design in figma
      minTextAdapt: true, /// true if you want to reduce the font size to fit the text
      splitScreenMode: true,   /// true if you want to split the screen mode
      builder: (context, child) {
      return  MaterialApp.router( // use go_router package for Navigation
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        
        theme: ThemeData(
          fontFamily: 'Manrope',
        scaffoldBackgroundColor: AppColors.backgroundColor
      ),

      );
    },);
   
  }
}
