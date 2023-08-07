class UserModel {
  String? uCartao;
  String? username;
  String? usercode;
  String? uPin;
  String? grupo;
  String? iniciais;

  UserModel(
      {this.uCartao,
        this.username,
        this.usercode,
        this.uPin,
        this.grupo,
        this.iniciais});

  UserModel.fromJson(Map<String, dynamic> json) {
    uCartao = json['u_cartao'];
    username = json['username'];
    usercode = json['usercode'];
    uPin = json['u_pin'];
    grupo = json['grupo'];
    iniciais = json['iniciais'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['u_cartao'] = this.uCartao;
    data['username'] = this.username;
    data['usercode'] = this.usercode;
    data['u_pin'] = this.uPin;
    data['grupo'] = this.grupo;
    data['iniciais'] = this.iniciais;
    return data;
  }
}