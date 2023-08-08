import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solbombas/constant/api_path.dart';
import 'package:solbombas/constant/controller.dart';
import 'package:solbombas/model/userModel.dart';
import 'package:solbombas/pages/bomba/bomba_page.dart';
import 'package:solbombas/pages/bomba/page/opcion_page.dart';
import 'package:solbombas/service/Http/service_data.dart';

class LoginController extends GetxController {
  static LoginController instance = Get.find();

  RxString result = "".obs;
  List<UserModel> user = <UserModel>[].obs;

  final userTextController = TextEditingController();
  final passTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _tagRead();
  }

  void _tagRead( ) {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var num = tag.data["mifareclassic"]["identifier"]
          .map((e) => e.toRadixString(16).padLeft(2, '0'))
          .join('');
      //var num = "ec328202";

      var numAgrupado = [];

      for (int i = 0; i < num.length; i += 2) {
        if (i + 1 < num.length) {
          numAgrupado.add(num.substring(i, i + 2));
        } else {
          numAgrupado.add(num.substring(i));
        }
      }

      var nu =
          numAgrupado[3] + numAgrupado[2] + numAgrupado[1] + numAgrupado[0];

      int decimal = int.parse(nu, radix: 16);
      var t = decimal.toString();

      while (t.length < 10) {
        t = "0$t";
      }
      print(t);

      result.value = t;
      await login();
      NfcManager.instance.stopSession();

    });
  }

  Future login() async {
    //var num = '3222140871';
    var num = result.value;

    if (num.isNull || num.isEmpty) {
      num = "0";
    }
    print("tes: " + userTextController.text.trim());
    var name = userTextController.text.trim();
    var code = passTextController.text.trim();

    var body = [
      {
        'usercode': name,
        'u_pin': code,
      }
    ];

    var data = await ServiceData.postService(body, "auth/$num");

    print("LOGIN");
    print(data);

    if (data != null) {
      user = data.map<UserModel>((json) => UserModel.fromJson(json)).toList();
      bombaController.getBombaList();
      bombaController.checkLoginStatus();

    } else {
      return Get.snackbar("SolAtlantico", "Utilizador não encontrado");
    }

    print(user.first.username);
  }
}
