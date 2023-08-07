import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:solbombas/constant/api_path.dart';
import 'package:solbombas/constant/controller.dart';
import 'package:solbombas/model/bombaModel.dart';
import 'package:solbombas/pages/bomba/bomba_page.dart';
import 'package:solbombas/pages/bomba/page/opcion_page.dart';
import 'package:solbombas/pages/bomba/widgets/bomba_popup.dart';
import 'package:solbombas/service/Http/service_data.dart';

import '../model/listBombasModel.dart';

class BombaController extends GetxController {
  static BombaController instance = Get.find();

  List<ListBombasModel> bombasList = <ListBombasModel>[].obs;
  List<BombaModel> bomba = <BombaModel>[].obs;

  var abert = "".obs;

  final valorBombaTextController = TextEditingController();

  @override
  void onInit() async{

    super.onInit();
  await getBombaList();
  }



  Future getBombaList({context}) async {
//lista de bombas existentes
    var data = await ServiceData.getService("bombasAll", context);

    print("Lista Bombas");
    print(data);

    if (data != null) {
      bombasList = data.map<ListBombasModel>((json) => ListBombasModel.fromJson(json)).toList();
    }
    else {
      return Get.snackbar("SolAtlantico", "Lista bombas não encontrado");
    }

    print(bombasList.first.username);
  }

  Future getBomba({required BuildContext context,nbomba, num}) async {
  //trazer dados de uma bomba em expecifico
    var data = await ServiceData.getService("bombascomb/$nbomba", context);

    print("Bombas");
    print(data);

    if (data != null) {
      bomba = data.map<BombaModel>((json) => BombaModel.fromJson(json)).toList();
      bombaPopup(title: "Bomba $nbomba", num: "1", context);
    }
    else {
      return Get.snackbar("SolAtlantico", "Dados da bomba não encontrado");
    }

    valorBombaTextController.text = bomba.first.contfim!;
    print(bombasList.first.username);
  }

  Future putBombas({context, num}) async {
//atualizar o login na bomba de combustivel(ocupado)
    var user = loginController.user.first.usercode.toString();
    var iniciais = loginController.user.first.iniciais.toString();
    String aberta = "1";


    var body = [{"username":user,
      "usrinis":iniciais, "aberta":aberta}];

    var data = await ServiceData.putService2(body, "bombas/$num");

    print("Update login bombas");
    print(data);

    if (data!=null) {
    }
    else {
      return Get.snackbar("SolAtlantico", "Erro login na Bomba");
    }

  }

  Future putUpdateBombas({context}) async {
//atualizar o login na bomba de combustivel(livre)
    var user = "";
    var iniciais = loginController.user.first.iniciais.toString();
    String aberta = "0";


    var body = [{"username":user,
      "usrinis":iniciais, "aberta":aberta}];

    var data = await ServiceData.putService2(body, "bombas/${bomba.first.bomba}");

    print("Update login bombas");
    print(data);

    if (data !=null) {
    }
    else {
      return Get.snackbar("SolAtlantico", "Erro atualiza estado da bomba");
    }

  }

  Future postBombasComb(String num, String title, {required BuildContext context}) async {
//atualizar se o valor da bomba de combustivel

    var now =  DateTime.now();
    var formatter =  DateFormat('yyyy-MM-dd');
    var dh = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    String formattedTime = DateFormat.Hms().format(now);
    String formattedDate = formatter.format(now);

    var user = loginController.user.first.usercode.toString();
    var iniciais = loginController.user.first.iniciais.toString();
    var datahora = dh.toString();
    var ndata = formattedDate.toString();
    var hora = formattedTime.toString();
    var contInicio = valorBombaTextController.text;
    var contfim = 0;
    var abastecido = 0;
    var contint = 0;
    var inactivo = 0;
    var marcada = 0;
    var bombac = bomba.first.bomba;



    var body = [{"username":user,
      "ousrinis":iniciais,
      "ousrdata":datahora,
      "data":ndata,
      "ousrhora":hora,
      "contfim":contfim,
      "continicio":contInicio,
      "abastecido":abastecido,
      "contint":contint,
      "bomba": bombac,
      "inactivo": inactivo,
      "marcada": marcada}];


    var data = await ServiceData.postCreate(body, "postbombacomb");

    print("Update qtt na bombas");
    print(data);

    if (data != null) {
      num == "1" ? Get.offAll((OpcionPage(bomba: title))) : Get.offAll(const BombaPage());
    }
    else {
      return Get.snackbar("SolAtlantico", "Erro");
    }

  }
}