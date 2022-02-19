class TokenModel {
  final String? token;
  final String? result;

  TokenModel({this.token, this.result});

  factory TokenModel.fromJson(Map json) {
    return TokenModel(
        token: json['token'] ?? 'Token not found',
        result: json['Result'] ?? 'Result not found');
  }
}
