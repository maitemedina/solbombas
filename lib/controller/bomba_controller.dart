

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solbombas/constant/controller.dart';
import 'package:solbombas/model/bombaModel.dart';
import 'package:solbombas/pages/bomba/bomba_page.dart';
import 'package:solbombas/pages/bomba/page/opcion_page.dart';
import 'package:solbombas/pages/bomba/widgets/bomba_popup.dart';
import 'package:solbombas/pages/login/login_page.dart';
import 'package:solbombas/service/Http/service_data.dart';

import '../model/listBombasModel.dart';

class BombaController extends GetxController {
  static BombaController instance = Get.find();

  List<ListBombasModel> bombasList = <ListBombasModel>[].obs;
  List<BombaModel> bomba = <BombaModel>[].obs;

  var abert = "".obs;

  final valorBombaTextController = TextEditingController();

  final _isLoggedIn = false.obs;
  final _numBomba = "".obs;
  final _username = "".obs;
  final valorBomba = "".obs;

  bool get isLoggedIn => _isLoggedIn.value;
  String get numBomba => _numBomba.value;
  String get username => _username.value;

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    _numBomba.value = prefs.getString('numBomba') ?? '';
    _username.value = prefs.getString('username') ?? '';

    if(bombaController.hasOptionWithSameUsername()&&isLoggedIn){
      getBomba( nbomba: numBomba);
      Get.offAll(OpcionPage(bomba: "Bomba $numBomba"));
    }else if(bombaController.hasOptionWithSameUsername()&&!isLoggedIn){
      Get.snackbar("SolAtlantico", "Sua conta encontra-se aberta em outro dispositivo");
    }else if(loginController.user.first.usercode != username&&isLoggedIn){
      Get.snackbar("SolAtlantico", "Esse aplicativo esta sendo usado por $username");
    }else{
      //Se não estiver logado, redirecione para a página de login.
         Get.offAll(BombaPage());
    }

    // if  (bombaController.hasOptionWithSameUsername()){
    //   getBomba( nbomba: bombaController.numBomba);
    //   Get.offAll(OpcionPage(bomba: "Bomba ${bombaController.numBomba ?? ''}"));
    //
    // }else if(bombaController.hasOptionWithSameUsername()&&_numBomba.isNotEmpty) {
    //
    // }else if (!isLoggedIn){
    //
    //   // Se não estiver logado, redirecione para a página de login.
    //   Get.offAll(BombaPage());
    // } else{
    //   // Se já estiver logado, redirecione para a página principal.
    //   getBomba( nbomba: bombaController.numBomba);
    //   Get.offAll(OpcionPage(bomba: "Bomba ${bombaController.numBomba ?? ''}"));
    // }
  }

  @override
  void onInit() async{

    super.onInit();
  await getBombaList();
  }



  Future getBombaList() async {
//lista de bombas existentes
    var data = await ServiceData.getService("bombasAll");

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

  bool hasOptionWithSameUsername(){
    bool sameUsername = bombasList.any((otherBomba) =>
    otherBomba.username == loginController.user.first.usercode);
    return sameUsername;
  }


  Future getBomba({nbomba}) async {
  //trazer dados de uma bomba em expecifico
    var data = await ServiceData.getService("bombascomb/$nbomba");

    print("Bombas");
    print(data);

    if (data != null) {
      bomba = data.map<BombaModel>((json) => BombaModel.fromJson(json)).toList();

      if (!isLoggedIn) {
        bombaPopup(title: "Bomba $nbomba", num: "1");
      }


      _isLoggedIn.value = true;
      _numBomba.value = numBomba;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      prefs.setString('numBomba', bomba.first.bomba??'');
      prefs.setString('valorBomba', bomba.first.contfim??'');
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

  Future putUpdateBombas() async {
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

  Future postBombasComb(String num, String title) async {
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
      num == "1" ? Get.offAll((OpcionPage(bomba: title))) : Get.offAll(LoginPage());

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', loginController.user.first.usercode.toString());
    }
    else {
      return Get.snackbar("SolAtlantico", "Erro");
    }

  }

  Future postCloseBombasComb(String num, String title) async {
//atualizar se o valor que a bomba de combustivel foi fechada

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
    var contInicio = 0;
    var contfim = valorBombaTextController.text;
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

    print("Update qtt na bombas no fecho");
    print(data);

    if (data != null) {
      if(num == "1"){
        Get.offAll((OpcionPage(bomba: title)));
      }else{
        loginController.tagRead();
        loginController.result.value="";
        logout();
        }
    }
    else {
      return Get.snackbar("SolAtlantico", "Erro");
    }

  }

  void logout() async {
    _isLoggedIn.value = false;
    _numBomba.value = "";
    _username.value = "";

    loginController.passTextController.clear();
    loginController.userTextController.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLoggedIn');
    prefs.remove('numBomba');
    prefs.remove('totalGasolina');
    prefs.remove('valorBomba');
    prefs.remove('username');
    Get.offAll( LoginPage());
  }

  addCombustivel()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var total = prefs.getDouble('totalGasolina') ?? 0.0;

    var abstecido = abastecerController.converterParaInteiro(total.toString());

    var bomb = abastecerController.converterParaInteiro(valorBombaTextController.text);

    bomb += abstecido;

    valorBombaTextController.text = bomb.toString();
  }

  removeCombustivel()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var total = prefs.getDouble('totalGasolina') ?? 0.0;

    var abstecido = abastecerController.converterParaInteiro(total.toString());

    var bomb = abastecerController.converterParaInteiro(valorBombaTextController.text);

    bomb -= abstecido;

    valorBombaTextController.text = bomb.toString();
  }
}