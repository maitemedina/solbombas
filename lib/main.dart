import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solbombas/constant/theme.dart';
import 'package:solbombas/controller/abastecer_controller.dart';
import 'package:solbombas/controller/bomba_controller.dart';
import 'package:solbombas/controller/login_controller.dart';
import 'package:solbombas/controller/matricula_controller.dart';
import 'package:solbombas/pages/login/login_page.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();


Get.put(LoginController());
Get.put(BombaController());
Get.put(MatriculaController());
Get.put(AbastecerController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sol Bombas',
      theme: getLightTheme(context),
      darkTheme: getDarkTheme(context),
      home: LoginPage(),
    );
  }
}
