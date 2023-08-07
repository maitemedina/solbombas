import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solbombas/constant/color.dart';
import 'package:solbombas/constant/controller.dart';
import 'package:solbombas/constant/images.dart';
import 'package:solbombas/constant/strings.dart';
import 'package:solbombas/constant/style.dart';
import 'package:solbombas/model/veiculosModel.dart';
import 'package:solbombas/pages/bomba/page/opcion_page.dart';
import 'package:solbombas/widgets/button_ui.dart';
import 'package:solbombas/widgets/custom_text_field.dart';

class AbastecerPage extends StatelessWidget {
  final String matricula;
  final String bomba;
  final VeiculosModel veiculo;

  const AbastecerPage({super.key, required this.matricula, required this.bomba, required this.veiculo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.main,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: ColorPalette.primary),
          onTap: () {
            Get.back();
          },
        ),
        title: Image.asset(Images.logo, width: 80),
        titleSpacing: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
                child: Text(loginController.user.first.usercode??'',
                    style: Styles.textRegular
                        .copyWith(color: ColorPalette.primary))),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(bomba, style: Styles.heading4.copyWith(color: ColorPalette.primary)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    Strings.registrationLabel,
                    style: Styles.textBold,
                  ),
                  Text(matricula, style: Styles.textRegular),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    Strings.driverLabel,
                    style: Styles.textBold,
                  ),
                  Text(matriculaController.motorista.first.cmdesc??'', style: Styles.textRegular),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: Strings.mileageLabel,
                keyboardType: TextInputType.number,
                textController: abastecerController.kmsController,
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                label: Strings.fuelLabel,
                keyboardType: TextInputType.number,
                textController: abastecerController.qttController,
              ),
              const SizedBox(height: 16.0),
              ButtonUI(label: Strings.saveLabel, action: () async{
                await abastecerController.putUpdateBombas(veiculo:veiculo, bombaText: bomba);
                abastecerController.qttController.clear();
              }, forceExtended: true)
            ],
          ),
        ),
      ),
    );
  }
}
