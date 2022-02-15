class NoteModel {
  final int id;
  final String title;
  final String description;
  final String created;

  NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.created,
  });

  factory NoteModel.fromJson(Map json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      created: json['created'],
    );
  }

  static List<NoteModel> getNotes(List data) {
    return data.map((e) => NoteModel.fromJson(e)).toList();
  }
}
