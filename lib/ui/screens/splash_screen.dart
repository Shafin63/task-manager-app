import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager2/ui/controllers/auth_controller.dart';
import 'package:task_manager2/ui/screens/login_screen.dart';
import 'package:task_manager2/ui/screens/main_navbar_holder_screen.dart';
import 'package:task_manager2/ui/utils/asset_path.dart';
import 'package:task_manager2/ui/widgets/screen_%20background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    // Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (_) => LoginScreen()),
    //     );
    final bool isLoggedIn = await AuthController.isUserAlreadyLoggedIn();

    if (isLoggedIn) {
      await AuthController.getUserData();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainNavbarHolderScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(child: SvgPicture.asset(AssetPaths.logoSvg, height: 50)),
      ),
    );
  }
}
