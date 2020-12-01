class SpendingModel {
  SpendingModel({
    this.id,
    this.amount,
    this.type,
    this.datetime,
    this.description,
  });

  int id;
  int amount;
  String type;
  String datetime;
  String description;

  factory SpendingModel.fromJson(Map<String, dynamic> json) => SpendingModel(
        id: json["_id"],
        amount: json["_amount"],
        type: json["_type"],
        datetime: json["_datetime"],
        description: json["_description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "_amount": amount,
        "_type": type,
        "_datetime": datetime,
        "_description": description,
      };
}
