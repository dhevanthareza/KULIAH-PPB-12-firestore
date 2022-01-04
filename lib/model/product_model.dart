class ProductModel {
  String? id;
  int? buyPrice;
  String? code;
  int? stockMin;
  String? satuan;
  String? name;
  int? sellPrice;
  int? stock;

  ProductModel({
    this.buyPrice,
    this.code,
    this.stockMin,
    this.satuan,
    this.name,
    this.sellPrice,
    this.stock,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    buyPrice = json['buyPrice'];
    code = json['code'];
    stockMin = json['stock_min'];
    satuan = json['satuan'];
    name = json['name'];
    sellPrice = json['sellPrice'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buyPrice'] = this.buyPrice;
    data['code'] = this.code;
    data['stock_min'] = this.stockMin;
    data['satuan'] = this.satuan;
    data['name'] = this.name;
    data['sellPrice'] = this.sellPrice;
    data['stock'] = this.stock;
    return data;
  }
}
