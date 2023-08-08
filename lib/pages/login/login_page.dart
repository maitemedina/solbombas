import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:solbombas/constant/controller.dart';
import 'package:solbombas/constant/images.dart';
import 'package:solbombas/constant/strings.dart';
import 'package:solbombas/pages/bomba/bomba_page.dart';
import 'package:solbombas/service/sqlserver/sql_server_conection.dart';
import 'package:solbombas/widgets/button_ui.dart';
import 'package:solbombas/widgets/custom_password_text_field.dart';
import 'package:solbombas/widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  final ValueNotifier<dynamic> result = ValueNotifier(null);
   LoginPage({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Image.asset(Images.logo, width: 280),
              const SizedBox(height: 15),
               Form(child: Column(
                children: [
                  Obx(() =>
                        Text('${loginController.result} '),
                  ),
                  CustomTextField(label: "", initialValue: Strings.nameLabel, textController: loginController.userTextController),
                  const SizedBox(height: 15),
                  CustomPasswordTextField(hintText: Strings.passwordLabel, requiredLabel: Strings.enterPasswordLabel,textController: loginController.passTextController),
                ],
              )),
              const SizedBox(height: 15),
              ButtonUI(label: Strings.enterLabel, action: () async{
                await loginController.login();
                },forceExtended: true)
            ],
          ),
        ),
      ),
    );


  }


}

