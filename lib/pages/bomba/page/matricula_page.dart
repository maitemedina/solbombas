import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solbombas/constant/color.dart';
import 'package:solbombas/constant/controller.dart';
import 'package:solbombas/constant/images.dart';
import 'package:solbombas/constant/style.dart';
import 'package:solbombas/pages/bomba/widgets/matricula_card.dart';

class MatriculaPage extends StatelessWidget {
  final String bomba;

  const MatriculaPage({super.key, required this.bomba});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.main,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back, color: ColorPalette.primary),
            onTap: () {
              Get.back();
              matriculaController.searchTextController.clear();
              matriculaController.filteredVeiculoList.clear();
              matriculaController.filteredVeiculoList.addAll(matriculaController.veiculosList);
            },
          ),
          title: Image.asset(Images.logo, width: 80),
          titleSpacing: 1,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Center(
                  child: Text(loginController.user.first.usercode ?? '',
                      style: Styles.textRegular
                          .copyWith(color: ColorPalette.primary))),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
          child: Column(
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(bomba,
                      style: Styles.heading5.copyWith(color: ColorPalette.primary)),
                ],
              ),
              const SizedBox(height: 8),
             // CustomTextFieldSearch(initialValue: Strings.searchHereLabel, textController: matriculaController.searchTextController),
             // const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  matriculaController.filterveiculos(value);
                },
                controller: matriculaController.searchTextController,
                decoration:  InputDecoration(
                    labelText: "Pesquisar",
                    hintText: "Pesquisar...",
                    prefixIcon: Icon(Icons.search, color: ColorPalette.primary),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: ColorPalette.primary)),
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: ColorPalette.secundary))
                ),
              ),
              const SizedBox(height: 5),
             // GetBuilder<MatriculaController>(builder: (controller) {
              //  return controller.veiculosList.isEmpty
               //     ? const Center(child: CustomCircularProgress())
                     Expanded(
                      child: Obx(()=>
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: matriculaController.filteredVeiculoList.length,
                            itemBuilder: (context, index){
                              return Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: MatriculaCard(veiculo: matriculaController.filteredVeiculoList[index], bomba: bomba));
                            }),
                      ),
                    )
             // }),
            ],
          ),
        ));
  }
}
