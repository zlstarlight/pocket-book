class CostInfo {
  int? category;
  String? count;
  String? date;
  String? tips;

  CostInfo({required this.category, required this.count, required this.date, required this.tips});

  CostInfo.fromMap(Map<String, dynamic> res)
      : category = res["category"],
        count = res["count"],
        date = res["date"],
        tips = res["tips"];

  Map<String, dynamic> toMap() {
    return {'category': category, 'count': count, "date": date, "tips": tips};
  }
}
