class ResultModel {
  final String result;

  ResultModel({required this.result});

  factory ResultModel.fromJson(Map json) {
    return ResultModel(result: json['Result']);
  }
}
