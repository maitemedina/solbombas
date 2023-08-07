import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solbombas/constant/color.dart';
import 'package:solbombas/constant/controller.dart';
import 'package:solbombas/constant/style.dart';
import 'package:solbombas/model/veiculosModel.dart';
import 'package:solbombas/pages/bomba/page/abastecer_page.dart';

class MatriculaCard extends StatelessWidget {
  final VeiculosModel veiculo;
  final String bomba;
  const MatriculaCard({super.key, required this.veiculo, required this.bomba});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color:  Theme.of(context).cardColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.directions_bus_outlined,
                size: 30, color: ColorPalette.secundary),
            const SizedBox(width: 30),
            Text(
              veiculo.matricula ??
                  '',
              style: Styles.heading7,
            ),
          ],
        ),
      ),
      onTap: () async{

        await matriculaController.getMotorista();
          Get.to(AbastecerPage(veiculo: veiculo,
              matricula: veiculo.matricula ??
                  '',
              bomba: bomba));
        },
    );
  }
}
