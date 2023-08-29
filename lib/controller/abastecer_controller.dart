
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solbombas/constant/controller.dart';
import 'package:solbombas/helpers/login_result.dart';
import 'package:solbombas/model/veiculosModel.dart';
import 'package:solbombas/pages/bomba/page/opcion_page.dart';
import 'package:solbombas/service/Http/service_data.dart';

class AbastecerController extends GetxController {
  static AbastecerController instance = Get.find();

  final  qttController = TextEditingController();
  final  kmsController = TextEditingController();
  RxDouble total = 0.0.obs;
  final FocusNode textFocus = FocusNode();


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    _loadTotalSum();
  }

  Future<LoginResult> putUpdateBombas({context, bombaText, required VeiculosModel veiculo}) async {
//abastecimento do veiculos com combustivel

    final FormState? form = formKey.currentState;
    if (!form!.validate()) {
      return LoginResult(false, errorMessage: "Campos Vazios");
    }

    var condutor = "";
    var ncondutor = 0;
    var ncartao = "";

    var iniciais = loginController.user.first.iniciais.toString();
    var user = loginController.user.first.usercode.toString();
    var bomba = bombaController.bomba.first.bomba.toString();

    int contint = converterParaInteiro(qttController.text);

    if(matriculaController.motorista.isNotEmpty){
       condutor = matriculaController.motorista.first.cmdesc.toString();
       ncondutor = int.parse(matriculaController.motorista.first.cm.toString());
       ncartao = matriculaController.motorista.first.uNcartao.toString();
    }


    var now =  DateTime.now();
    var formatter =  DateFormat('yyyy-MM-dd');
    var dh = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second, now.millisecond);
    String formattedTime = DateFormat.Hms().format(now);
    String formattedDate = formatter.format(now);

    String dataFormatada = getDataFormatada(dh.toString());
    String numAleatorios = gerarTresDigitosAleatorios();
    var id = iniciais+dataFormatada+numAleatorios;

    var body = [{
    "kmsatehoje": kmsController.text,
    "ultimadata": dh.toString(),
    "qtt": qttController.text,
    "condutor": condutor,
    "u_bomba": bomba,
    "u_ncartao": ncartao,
    "nmotorista": ncondutor,
    "inic_func": iniciais,
    "hora": formattedTime,
    "tipo": veiculo.tipo,
    "itstamp": id,
    "marca": veiculo.marca,
    "modelo": veiculo.modelo,
    "particular": 0,
    "activo": 0,
    "compras": 0,
    "marcada": veiculo.marcada,
    "username":user,
    "data":formattedDate,
    "contfim":0,
    "continicio":0,
    "contint":contint,
    "nofrota":veiculo.nofrota??''
    }];


    print('abastecer');
    print(jsonEncode(body));
    var data = await ServiceData.putService2(body, "updatecomb/${veiculo.matricula}");

    print("Update login bombas");
    print(data);

    if (data != null) {
      addToTotal();
      //abastecerController.qttController.clear();
      matriculaController.motorista.clear();
      matriculaController.condutor.value = '';
      matriculaController.ncontadr.value = '';
      Get.offAll(OpcionPage(bomba: "Bomba $bomba"));
    }
    else {
      Get.snackbar("SolAtlantico", "Erro no abastecimento");
      return LoginResult(false, errorMessage: "Erro no abastecimento");
    }
    return LoginResult(true);
  }

  String getDataFormatada(String dataOriginal) {
    print(dataOriginal);
    // Remova os caracteres especiais da data original
    String dataSemCaracteresEspeciais = dataOriginal.replaceAll(RegExp(r'[-:.]'), '');

    // Extraia o ano, mês, dia, hora, minuto e segundo da data
    String ano = dataSemCaracteresEspeciais.substring(2, 4);
    String mes = dataSemCaracteresEspeciais.substring(4, 6);
    String dia = dataSemCaracteresEspeciais.substring(6, 8);
    String hora = dataSemCaracteresEspeciais.substring(8, 10);
    String minuto = dataSemCaracteresEspeciais.substring(10, 12);
    String segundo = dataSemCaracteresEspeciais.substring(12, 14);

    // Concatene os elementos para obter o formato desejado
    String dataConvertida =
        '$ano$mes$dia$hora$minuto$segundo${dataSemCaracteresEspeciais.substring(14)}';
    //remover os espacos
    String num = dataConvertida.replaceAll(' ', '');
    return num;
  }

  String gerarTresDigitosAleatorios() {
    // Crie uma instância da classe Random
    var random = Random();

    // Gere um número aleatório entre 0 e 999 (pois queremos 3 dígitos)
    int numeroAleatorio = random.nextInt(1000);

    // Formate o número para garantir que tenha 3 dígitos
    String tresDigitos = numeroAleatorio.toString().padLeft(3, '0');

    return tresDigitos;
  }

  int converterParaInteiro(String valor) {
    // Tentar converter o valor para double
    double? valorDouble = double.tryParse(valor);

    if (valorDouble != null) {
      // Se for possível converter para double, usar o método .round() para arredondar
      return valorDouble.round();
    } else {
      // Caso contrário, converter diretamente para inteiro
      return int.tryParse(valor) ?? 0; // Se não for possível converter para int, retornar 0
    }
  }

  void _loadTotalSum() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    total.value = prefs.getDouble('totalGasolina') ?? 0.0;
  }

  void addToTotal() async {
    double newValue = double.tryParse(qttController.text) ?? 0.0;
    total.value += newValue;
    print(qttController.text);
    print("PRINTSHARED");
    print(total.value);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('totalGasolina', total.value);

    qttController.clear();
  }
}