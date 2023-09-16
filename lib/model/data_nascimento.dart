class DataNascimento {
  String? sType;
  String? iso;

  DataNascimento({this.sType, this.iso});

  DataNascimento.fromJson(Map<String, dynamic> json) {
    sType = json['__type'];
    iso = json['iso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__type'] = sType;
    data['iso'] = iso;
    return data;
  }
}
