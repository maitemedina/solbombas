import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solbombas/constant/images.dart';
import 'package:solbombas/constant/style.dart';

class BombaCard extends StatelessWidget {
  final String bomba;
  const BombaCard({super.key, required this.bomba});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Theme.of(context).cardColor),
      child: Row(
        children: [
          Image.asset(Images.gasolina, height: 25),
          const SizedBox(width: 16),
          Text(bomba, style: Styles.textBold),
        ],
      ),
    );
  }
}
