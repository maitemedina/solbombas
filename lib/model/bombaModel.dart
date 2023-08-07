class BombaModel {
  String? contfim;
  String? bomba;
  String? data;
  String? ousrhora;

  BombaModel({this.contfim, this.bomba, this.data, this.ousrhora});

  BombaModel.fromJson(Map<String, dynamic> json) {
    contfim = json['contfim'];
    bomba = json['bomba'];
    data = json['data'];
    ousrhora = json['ousrhora'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contfim'] = this.contfim;
    data['bomba'] = this.bomba;
    data['data'] = this.data;
    data['ousrhora'] = this.ousrhora;
    return data;
  }
}