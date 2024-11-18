import 'package:equatable/equatable.dart';

class WeightType extends Equatable {
  int? id;
  String? name;
  String? description;
  String? unit;
  String? price;
  String? createdAt;
  String? updatedAt;

  WeightType(
      {this.id,
      this.name,
      this.description,
      this.unit,
      this.price,
      this.createdAt,
      this.updatedAt});

  WeightType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    unit = json['unit'];
    price = json['price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['unit'] = this.unit;
    data['price'] = this.price;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, name, description, unit, price, createdAt, updatedAt];
}
