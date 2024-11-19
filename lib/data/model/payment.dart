class Payment {
  int? id;
  int? amount;
  String? externalId;
  String? invoiceUrl;
  String? expiryDate;
  String? updatedAt;
  String? createdAt;

  Payment(
      {this.id,
      this.amount,
      this.externalId,
      this.invoiceUrl,
      this.expiryDate,
      this.updatedAt,
      this.createdAt});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = int.parse(json['amount']);
    externalId = json['external_id'];
    invoiceUrl = json['invoice_url'];
    expiryDate = json['expiry_date'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['external_id'] = this.externalId;
    data['invoice_url'] = this.invoiceUrl;
    data['expiry_date'] = this.expiryDate;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
