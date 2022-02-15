
import 'package:get/get.dart';

import '../models/note_model.dart';
import '../services/notes_api.dart';

class Controller extends GetxController {
  Future<List<NoteModel>>? notesData;

  RxBool didChangePage = true.obs;

  didThePageChange(bool val) {
    didChangePage.value = val;
  }

  getNoteData() {
    notesData = NotesApi().getNotesApi();
  }

  @override
  void onInit() {
    getNoteData();
    super.onInit();
  }
}
