class VeiculosModel {
  String? matricula;
  String? kmsatehoje;
  String? marca;
  String? modelo;
  String? marcada;
  String? tipo;
  String? ultimadata;
  String? ultimokm;
  String? nofrota;

  VeiculosModel(
      {this.matricula,
        this.kmsatehoje,
        this.marca,
        this.modelo,
        this.marcada,
        this.tipo,
        this.ultimadata,
        this.ultimokm,
        this.nofrota});

  VeiculosModel.fromJson(Map<String, dynamic> json) {
    matricula = json['matricula'];
    kmsatehoje = json['kmsatehoje'];
    marca = json['marca'];
    modelo = json['modelo'];
    marcada = json['marcada'];
    tipo = json['tipo'];
    ultimadata = json['ultimadata'];
    ultimokm = json['ultimokm'];
    nofrota = json['nofrota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matricula'] = this.matricula;
    data['kmsatehoje'] = this.kmsatehoje;
    data['marca'] = this.marca;
    data['modelo'] = this.modelo;
    data['marcada'] = this.marcada;
    data['tipo'] = this.tipo;
    data['ultimadata'] = this.ultimadata;
    data['ultimokm'] = this.ultimokm;
    data['nofrota'] = this.nofrota;
    return data;
  }
}