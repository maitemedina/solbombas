import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:solbombas/constant/color.dart';
import 'package:solbombas/constant/controller.dart';
import 'package:solbombas/constant/images.dart';
import 'package:solbombas/constant/strings.dart';
import 'package:solbombas/constant/style.dart';
import 'package:solbombas/controller/bomba_controller.dart';
import 'package:solbombas/pages/bomba/widgets/bomba_popup.dart';
import 'package:solbombas/widgets/custom_circular_progress.dart';

import 'widgets/bomba_card.dart';

class BombaPage extends StatelessWidget {
  const BombaPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.main,
        leading: Image.asset(Images.logo),
        leadingWidth: 100,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.login_outlined, color: ColorPalette.primary))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  Strings.employeeLabel,
                  style: Styles.textBold,
                ),
                Text(loginController.user.first.usercode ?? "",
                    style: Styles.textRegular),
              ],
            ),
            const SizedBox(height: 16),
            GetBuilder<BombaController>(
               builder: (controller) {
                 return controller.bombasList.isEmpty ? const Center(child: CustomCircularProgress()) :Expanded(
                          child: EasyRefresh(
                            header: ClassicalHeader(
                              infoColor: ColorPalette.primary,
                              refreshedText: "Atualizado!!",
                              refreshingText: "Atualizando...",
                              refreshReadyText: "Atualizar"
                            ),
                            onRefresh: ()async{
                              await bombaController.getBombaList();
                            },
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.bombasList.length,
                              itemBuilder: (context, index) {
                                controller.abert.value = controller.bombasList[index].aberta.toString();
                                return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: GestureDetector(
                                  child: BombaCard(
                                    bomba: controller.bombasList[index],
                                  ),
                                  onTap: () async{
                                    controller.abert.value = controller.bombasList[index].aberta.toString();
                                    if (controller.bombasList[index].aberta == "0"|| controller.bombasList[index].username == loginController.user.first.usercode) {
                                      await controller.putBombas(context: context,num: controller.bombasList[index].bomba.toString());
                                      await controller.getBomba(nbomba: controller.bombasList[index].bomba.toString(), context: context, num:"1");
                                      //bombaPopup(title: "Bomba ${controller.bombasList[index].bomba}", num: "1", context);
                                    }else{
                                      Get.snackbar("SolAtlantico", "Essa bomba esta a ser utilizada por ${controller.bombasList[index].username}");
                                    }
                                  },
                                ),
                              );}
                            ),
                          ),
                        );
               }
             ),

          ],
        ),
      ),
    );
  }
}
