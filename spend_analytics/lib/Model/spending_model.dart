class SpendingModel {
  SpendingModel({
    this.id,
    this.amount,
    this.type,
    this.mode,
    this.datetime,
    this.description,
  });

  int? id;
  double? amount;
  String? type;
  String? mode;
  String? datetime;
  String? description;

  factory SpendingModel.fromJson(Map<String, dynamic> json) => SpendingModel(
        id: json["_id"],
        amount: json["_amount"],
        type: json["_type"],
        mode: json["_mode"],
        datetime: json["_datetime"],
        description: json["_description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "_amount": amount,
        "_type": type,
        "_mode": mode,
        "_datetime": datetime,
        "_description": description,
      };
}
