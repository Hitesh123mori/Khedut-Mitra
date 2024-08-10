class AIResponse {
  final String bestMedicine;
  final String amountPerAcre;
  final String approximateTime;

  AIResponse({
    required this.bestMedicine,
    required this.amountPerAcre,
    required this.approximateTime,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) {
    return AIResponse(
      bestMedicine: json['bestMedicine'],
      amountPerAcre: json['amountPerAcre'],
      approximateTime: json['approximateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bestMedicine': bestMedicine,
      'amountPerAcre': amountPerAcre,
      'approximateTime': approximateTime,
    };
  }
}
