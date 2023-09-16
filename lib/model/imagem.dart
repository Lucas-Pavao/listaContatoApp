class Imagem {
  String? sType;
  String? name;
  String? url;

  Imagem({this.sType, this.name, this.url});

  Imagem.fromJson(Map<String, dynamic> json) {
    sType = json['__type'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__type'] = sType;
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
