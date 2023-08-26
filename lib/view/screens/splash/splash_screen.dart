import 'package:flutter/material.dart';
import 'package:to_do_app/veiw_model/data/local/cash_helper.dart';
import 'package:to_do_app/veiw_model/data/local/local_keys.dart';
import 'package:to_do_app/veiw_model/utils/app_assets.dart';
import 'package:to_do_app/view/screens/auth/login_screen.dart';
import 'package:to_do_app/view/screens/home/all_tasks_screen.dart';


import '../../../veiw_model/utils/navigation.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 1),(){
      if(CashHelper.get(key: LocalKeys.uid) ==null){
      Navigation.pushAndRemove(context, LoginScreen());}
      else {Navigation.push(context, AllTasksScreen());}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppAssets.logoIcon),
      ),
    );
  }
}
