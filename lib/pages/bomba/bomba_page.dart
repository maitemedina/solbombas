import 'package:flutter/material.dart';
import 'package:solbombas/constant/color.dart';
import 'package:solbombas/constant/images.dart';
import 'package:solbombas/constant/strings.dart';
import 'package:solbombas/constant/style.dart';
import 'package:solbombas/pages/bomba/widgets/bomba_popup.dart';

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
          IconButton(onPressed: (){}, icon: Icon(Icons.login_outlined, color: ColorPalette.primary))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(Strings.employeeLabel, style: Styles.textBold,),
                Text("Ana Maria", style: Styles.textRegular),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 15,
                itemBuilder: (context, index) =>  Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: GestureDetector(
                    child: BombaCard(
                      bomba: "Bomba $index",
                    ),
                    onTap: (){
                      bombaPopup(title: "Bomba $index", num: "1");
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
