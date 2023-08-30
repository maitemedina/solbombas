import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solbombas/constant/color.dart';
import 'package:solbombas/constant/controller.dart';
import 'package:solbombas/constant/images.dart';
import 'package:solbombas/constant/strings.dart';
import 'package:solbombas/constant/style.dart';
import 'package:solbombas/model/veiculosModel.dart';
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
            abastecerController.qttController.clear();
            matriculaController.motorista.clear();
            matriculaController.condutor.value = '';
            matriculaController.ncontadr.value = '';
            matriculaController.searchTextController.clear();
            matriculaController.filteredVeiculoList.clear();
            matriculaController.filteredVeiculoList.addAll(matriculaController.veiculosList);

           // FocusScope.of(context).requestFocus(matriculaController.searchFieldFocusNode);
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(bomba, style: Styles.heading5.copyWith(color: ColorPalette.primary)),
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
                  Obx(()=> matriculaController.condutor.isNotEmpty ? Text(
                      matriculaController.driverLabel.value,
                    style: Styles.textBold)
                          : const SizedBox()),
                  Obx(()=> matriculaController.condutor.isNotEmpty ? Text(matriculaController.condutor.toString(), style: Styles.textRegular) : const SizedBox()),
                ],
              ),
              const SizedBox(height: 16),
              Form(
                key: abastecerController.formKey,
                child: Column(
                  children: [
                    matriculaController.ncontadr.toString() !='0'
                        ?const SizedBox()
                        :CustomTextField(
                      label: Strings.mileageLabel,
                      keyboardType: TextInputType.number,
                      textController: abastecerController.kmsController,
                      enable: matriculaController.ncontadr.toString() =='0' ? true: false,
                      action: (){
                        FocusScope.of(context).requestFocus(abastecerController.textFocus);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      focusNode: abastecerController.textFocus,
                      label: Strings.fuelLabel,
                      keyboardType: TextInputType.number,
                      textController: abastecerController.qttController,
                      requiredLabel: Strings.enterFuelLabel,
                      action: () async{
                        if(matriculaController.ncontadr.toString() =='0' && matriculaController.condutor.isEmpty){
                          Get.snackbar("SolAtlantico", "Passa o cartão de motorista!!");
                        }else{
                          if(int.parse(veiculo.kmsatehoje.toString()) <= int.parse(abastecerController.kmsController.text.toString()) ) {
                            await abastecerController.putUpdateBombas(
                                veiculo: veiculo, bombaText: bomba);

                          }else{
                            Get.snackbar("SolAtlantico", "O valor inserido tem que ser maior que o valor encontrado no autocarro!!");
                          }
                        };
                      }
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Obx(
                  ()=> ButtonUI(label: Strings.saveLabel, action: () async{
                    if(int.parse(veiculo.kmsatehoje.toString()) <= int.parse(abastecerController.kmsController.text.toString()) ) {
                      await abastecerController.putUpdateBombas(
                          veiculo: veiculo, bombaText: bomba);

                    }else{
                      Get.snackbar("SolAtlantico", "O valor inserido tem que ser maior que o valor encontrado no autocarro!!");
                    }
                }, forceExtended: true, disable: matriculaController.ncontadr.toString() !='0' ? true : matriculaController.condutor.isEmpty ? false : true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
