import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:solbombas/constant/controller.dart';
import 'package:solbombas/model/veiculosModel.dart';
import 'package:solbombas/service/Http/service_data.dart';

import '../model/motoristaModel.dart';

class MatriculaController extends GetxController {
  static MatriculaController instance = Get.find();

  List<VeiculosModel> veiculosList = <VeiculosModel>[].obs;
  List<MotoristaModel> motorista = <MotoristaModel>[].obs;

  RxString result = "".obs;

  final RxList<VeiculosModel> filteredVeiculoList = RxList<VeiculosModel>();

  final  searchTextController = TextEditingController();

  final RxString  searchText = ''.obs;

  // @override
  // void onInit() async{
  //   super.onInit();
  //   await getVeiculoList();
  //   filteredVeiculoList.addAll(veiculosList);
  // }

  Future getVeiculoList({context}) async {

    var data = await ServiceData.getService("veiculos", context);

    print("Lista veiculos");
    print(data);

    if (data != null) {
      veiculosList = data.map<VeiculosModel>((json) => VeiculosModel.fromJson(json)).toList();
      filteredVeiculoList.addAll(veiculosList);

    }
    else {
      return Get.snackbar("SolAtlantico", "Lista veiculos não encontrado");
    }

  }

  void filterveiculos(String matricula) {
    final query = searchTextController.text.toLowerCase();
    if (query.isEmpty) {
      // Se a pesquisa estiver vazia, exibe todos os itens
      filteredVeiculoList.assignAll(veiculosList);
    } else {
      // Filtra os itens com base no termo de pesquisa
      filteredVeiculoList.assignAll(veiculosList.where((item) =>
          item.matricula!.toLowerCase().contains(query)));
    }
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }

  void tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var num = tag.data["mifareclassic"]["identifier"].map((e) =>
          e.toRadixString(16).padLeft(2, '0')).join('');
      //var num = "ec328202";

      var numAgrupado = [];

      for (int i = 0; i < num.length; i += 2) {
        if (i + 1 < num.length) {
          numAgrupado.add(num.substring(i, i + 2));
        } else {
          numAgrupado.add(num.substring(i));
        }
      }

      var nu = numAgrupado[3] + numAgrupado[2] + numAgrupado[1] +
          numAgrupado[0];

      int decimal = int.parse(nu, radix: 16);
      var t = decimal.toString();

      while (t.length < 10) {
        t = "0$t";
      }
      print(t);


      result.value = t;

      NfcManager.instance.stopSession();
      await getMotorista(num: result.value);
    });
  }

  Future getMotorista({context, num}) async {

    var id = '2333553860';

    var data = await ServiceData.getService("motorista/$id", context);

    print("motorista");
    print(data);

    if (data != null) {
      motorista = data.map<MotoristaModel>((json) => MotoristaModel.fromJson(json)).toList();
    }
    else {
      return Get.snackbar("SolAtlantico", "Motorista não encontrado");
    }

  }
}
