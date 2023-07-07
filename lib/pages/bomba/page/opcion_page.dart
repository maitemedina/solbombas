import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solbombas/constant/color.dart';
import 'package:solbombas/constant/images.dart';
import 'package:solbombas/constant/strings.dart';
import 'package:solbombas/constant/style.dart';
import 'package:solbombas/pages/bomba/page/matricula_page.dart';
import 'package:solbombas/pages/bomba/widgets/bomba_popup.dart';

class OpcionPage extends StatelessWidget {
  final String bomba;
  const OpcionPage({super.key, required this.bomba});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.main,
        leading: Image.asset(Images.logo),
        leadingWidth: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
                child: Text("Ana Maria",
                    style: Styles.textRegular
                        .copyWith(color: ColorPalette.primary))),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(bomba, style: Styles.heading4.copyWith(color: ColorPalette.primary)),
              const SizedBox(height: 16),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 18),
                  width: Get.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorPalette.primary),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Theme.of(context).cardColor),
                  child: Row(
                    children: [
                      Icon(Icons.cable_rounded,
                          color: ColorPalette.primary, size: 35),
                      const SizedBox(width: 20),
                      Text(Strings.toFuelLabel,
                          style: Styles.heading2
                              .copyWith(color: ColorPalette.primary)),
                    ],
                  ),
                ),
                onTap: (){
                  Get.to(MatriculaPage(bomba:bomba));
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 18),
                  width: Get.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorPalette.secundary),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Theme.of(context).cardColor),
                  child: Row(
                    children: [
                      Icon(Icons.login_outlined,
                          color: ColorPalette.secundary, size: 35),
                      const SizedBox(width: 20),
                      Text(Strings.closeLabel,
                          style: Styles.heading2
                              .copyWith(color: ColorPalette.secundary)),
                    ],
                  ),
                ),
                onTap: (){
                  bombaPopup(title: bomba, num: "0");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
