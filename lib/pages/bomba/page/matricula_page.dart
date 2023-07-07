import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solbombas/constant/color.dart';
import 'package:solbombas/constant/images.dart';
import 'package:solbombas/constant/strings.dart';
import 'package:solbombas/constant/style.dart';
import 'package:solbombas/pages/bomba/page/abastecer_page.dart';
import 'package:solbombas/widgets/custom_text_field_search.dart';

class MatriculaPage extends StatelessWidget {
  final String bomba;
  const MatriculaPage( {super.key, required this.bomba});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.main,
          leading: GestureDetector(
              child: Icon(Icons.arrow_back, color: ColorPalette.primary),
            onTap: (){
                Get.back();
            },
          ),
          title: Image.asset(Images.logo, width: 80),
          titleSpacing: 1,
          actions: [

            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Center(
                  child: Text("Ana Maria",
                      style: Styles.textRegular
                          .copyWith(color: ColorPalette.primary))),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(bomba, style: Styles.heading4.copyWith(color: ColorPalette.primary)),
              const SizedBox(height: 8),
              CustomTextFieldSearch(initialValue: Strings.searchHereLabel),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  itemCount: 100,
                  itemBuilder: (context, index) => GestureDetector(
                    child: Row(
                      children: [
                         Icon(Icons.directions_bus_outlined, size: 30, color: ColorPalette.secundary),
                        const SizedBox(width: 10),
                        Text(
                          'ST-$index-AX',
                          style: Styles.heading7,
                        ),
                      ],
                    ),
                    onTap: (){
                      Get.to(AbastecerPage(matricula: 'ST-$index-AX', bomba: bomba));
                    },
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
