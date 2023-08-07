class MotoristaModel {
  String? cm;
  String? cmdesc;
  String? uNope;
  String? uNcartao;
  String? inactivo;

  MotoristaModel(
      {this.cm, this.cmdesc, this.uNope, this.uNcartao, this.inactivo});

  MotoristaModel.fromJson(Map<String, dynamic> json) {
    cm = json['cm'];
    cmdesc = json['cmdesc'];
    uNope = json['u_nope'];
    uNcartao = json['u_ncartao'];
    inactivo = json['inactivo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cm'] = this.cm;
    data['cmdesc'] = this.cmdesc;
    data['u_nope'] = this.uNope;
    data['u_ncartao'] = this.uNcartao;
    data['inactivo'] = this.inactivo;
    return data;
  }
}