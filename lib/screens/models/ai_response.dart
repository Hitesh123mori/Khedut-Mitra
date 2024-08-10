class AIResponse {
  final String best_pesticide;
  final String amount_per_acre;
  final String recovery_time;

  AIResponse({
    required this.best_pesticide,
    required this.amount_per_acre,
    required this.recovery_time,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) {
    return AIResponse(
      best_pesticide: json['best_pesticide'],
      amount_per_acre: json['amount_per_acre'],
      recovery_time: json['recovery_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'best_pesticide': best_pesticide,
      'amount_per_acre': amount_per_acre,
      'recovery_time': recovery_time,
    };
  }
}
