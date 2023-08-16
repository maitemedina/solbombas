import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:solbombas/constant/color.dart';
import 'package:solbombas/constant/controller.dart';
import 'package:solbombas/constant/images.dart';
import 'package:solbombas/constant/style.dart';
import 'package:solbombas/controller/matricula_controller.dart';
import 'package:solbombas/model/veiculosModel.dart';
import 'package:solbombas/pages/bomba/widgets/matricula_card.dart';
import 'package:solbombas/widgets/custom_circular_progress.dart';

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

              GetBuilder<MatriculaController>(builder: (controller) {
                return controller.veiculosList.isEmpty
                    ? const Center(child: CustomCircularProgress())
                    : Expanded(
                        child: SearchableList<VeiculosModel>(
                          focusNode: controller.searchFieldFocusNode,
                          initialList: matriculaController.veiculosList,
                          builder: (VeiculosModel user) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: MatriculaCard(veiculo: user, bomba: bomba),
                          ),
                          filter: (value) => matriculaController.veiculosList.where((element) => element.matricula!.toLowerCase().contains(value),).toList(),
                          emptyWidget:  const Text("Vazio"),
                          inputDecoration: InputDecoration(
                            labelText: "Pesquisar Matricula",
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        // ListView.builder(
                        //   itemCount: controller.filteredVeiculoList.length,
                        //   itemBuilder: (context, index) => GestureDetector(
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(bottom: 8.0),
                        //       child: MatriculaCard(veiculo: controller.filteredVeiculoList[index]),
                        //     ),
                        //     onTap: () {
                        //       Get.to(AbastecerPage(
                        //           matricula: controller
                        //                   .filteredVeiculoList[index].matricula ??
                        //               '',
                        //           bomba: bomba));
                        //     },
                        //   ),
                        //   // gridDelegate:
                        //   //     const SliverGridDelegateWithFixedCrossAxisCount(
                        //   //   crossAxisCount: 2,
                        //   //   childAspectRatio: 3,
                        //   // ),
                        // ),
                      );
              }),
            ],
          ),
        ));
  }
}
