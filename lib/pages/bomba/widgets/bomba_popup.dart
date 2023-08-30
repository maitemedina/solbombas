
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solbombas/constant/color.dart';
import 'package:solbombas/constant/controller.dart';
import 'package:solbombas/constant/strings.dart';
import 'package:solbombas/constant/style.dart';
import 'package:solbombas/widgets/custom_text_field.dart';

void bombaPopup( {required String title, required String num}){
  Get.defaultDialog(
    barrierDismissible: false,
      title: title, titleStyle: Styles.heading6.copyWith(color: ColorPalette.primary),
      content:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
         // mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(label: Strings.countFuelLabel, keyboardType: TextInputType.number,
            textController: bombaController.valorBombaTextController),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: Text(Strings.cancelLabel, style: Styles.leadN)),
                  onTap: ()async{
                    if(num == "1") {
                      await bombaController.putUpdateBombas();
                    }else{
                      bombaController.removeCombustivel();
                    }
                    Get.back();
                  },
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: Text(Strings.okLabel, style: Styles.lead.copyWith(color: ColorPalette.primary))),
                  onTap: ()async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    bombaController.valorBomba.value = prefs.getString('valorBomba') ?? '';
                    print("TESTEFECHAR");
                    print(int.parse(bombaController.valorBomba.value));
                    print(int.parse(bombaController.valorBombaTextController.text));

                    if(int.parse(bombaController.valorBomba.value) <= int.parse(bombaController.valorBombaTextController.text)) {
                      if (num == "0") {
                        await bombaController.putUpdateBombas();
                        bombaController.postCloseBombasComb(num, title);
                      } else {
                        bombaController.postBombasComb(
                            num, title);
                        //num == "1" ? Get.offAll((OpcionPage(bomba: title))) : Get.offAll(const BombaPage());
                      }
                    }else{
                      Get.snackbar("SolAtlantico", "O valor inserido nâo pode ser menor que o valor encontrado na bomba!!");
                    }
                  },
                ),
              ],
            ),

          ],
        ),
      ),
      radius: 10.0);
}