import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';

class LoginController extends GetxController {
  static LoginController instance = Get.find();

  RxString result = "".obs;

  @override
  void onInit() {
    super.onInit();
    _tagRead();
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var num = tag.data["mifareclassic"]["identifier"].map((e) => e.toRadixString(16).padLeft(2, '0')).join('');
      //var num = "ec328202";

      var numAgrupado = [];

      for (int i = 0; i < num.length; i += 2) {
        if (i + 1 < num.length) {
          numAgrupado.add(num.substring(i, i + 2));
        } else {
          numAgrupado.add(num.substring(i));
        }
      }

      var nu = numAgrupado[3]+numAgrupado[2]+numAgrupado[1]+numAgrupado[0];

      int decimal = int.parse(nu, radix: 16);
      var t = decimal.toString();

      while (t.length < 10) {
        t = "0$t";
      }
      print(t);


      result.value = t;

      NfcManager.instance.stopSession();
    });
  }
}
