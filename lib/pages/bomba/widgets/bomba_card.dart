import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solbombas/constant/color.dart';
import 'package:solbombas/constant/controller.dart';
import 'package:solbombas/constant/images.dart';
import 'package:solbombas/constant/style.dart';
import 'package:solbombas/controller/bomba_controller.dart';
import 'package:solbombas/model/listBombasModel.dart';

class BombaCard extends GetWidget<BombaController> {
  final ListBombasModel bomba;
  const BombaCard({super.key, required this.bomba});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: bombaController.abert.value =='0' ? Theme.of(context).cardColor : ColorPalette.gray),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(Images.gasolina, height: 25),
                const SizedBox(width: 16),
                Text("Bomba ${bomba.bomba}", style: Styles.textBold),
              ],
            ),
            Text(bomba.username??'', style: Styles.textRegular.copyWith(fontSize: 12)),
          ],
        ),
    );
  }
}
