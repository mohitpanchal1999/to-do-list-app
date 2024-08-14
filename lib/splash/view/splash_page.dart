import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_list_app/application/hive_db/db_main.dart';
import 'package:to_do_list_app/application/utils/app_icons.dart';
import '../../app_global_components/animated_splash_screen.dart';
import '../../application/utils/app_color.dart';

class SplashScreen extends StatefulWidget {
  final bool isLoggedIn;
  const SplashScreen({super.key, this.isLoggedIn = false});

  @override
  State createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  late DateTime startTime;
  bool splashTimeEnded = false;

  @override
  void initState() {
    super.initState();
  }
  /// add all line here for initializeSettings the value or any third party lib like firebase,q  preference value etc
  static Future<String> initializeSettings() async{
    /// Mobile device configuration
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    await dbMain.dbInit();

    return "/task_page";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: dPrimaryColor,
        body: AnimatedSplashScreen(
            duration: 1000,
            splash: AppIcons.iconSvgProvider(imageUrl: AppIcons.splashScreenIcon,iconSize: const Size(512, 512)),
            nextScreen: const SizedBox(),splashIconSize: MediaQuery.of(context).size.shortestSide * 0.4,animationDuration: const Duration(milliseconds: 800),
            splashTransition: SplashTransition.scaleTransition,function: ()=> initializeSettings(),
            type: SplashType.backgroundScreenReturn,
            backgroundColor: dPrimaryColor)
    );
  }
}

