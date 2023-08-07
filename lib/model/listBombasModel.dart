class ListBombasModel {
  String? bomba;
  String? username;
  String? usrinis;
  String? aberta;

  ListBombasModel({this.bomba, this.username, this.usrinis, this.aberta});

  ListBombasModel.fromJson(Map<String, dynamic> json) {
    bomba = json['bomba'];
    username = json['username'];
    usrinis = json['usrinis'];
    aberta = json['aberta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bomba'] = this.bomba;
    data['username'] = this.username;
    data['usrinis'] = this.usrinis;
    data['aberta'] = this.aberta;
    return data;
  }
}