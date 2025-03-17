class BodyRequestDailyFrenchCash {
  final List<String> accountId;
  final bool creditOrDepit;
  final String dateFrom;
  final String dateTo;

  BodyRequestDailyFrenchCash({
    required this.accountId,
    required this.creditOrDepit,
    required this.dateFrom,
    required this.dateTo,
  });
  factory BodyRequestDailyFrenchCash.fromJson(Map<String, dynamic> json) {
    return BodyRequestDailyFrenchCash(
      accountId: json['accountId'],
      creditOrDepit: json['creditOrDepit'],
      dateFrom: json['dateFrom'],
      dateTo: json['dateTo'],
    );
  }
  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "creditOrDepit": creditOrDepit,
        "dateFrom": dateFrom,
        "dateTo": dateTo,
      };
}
