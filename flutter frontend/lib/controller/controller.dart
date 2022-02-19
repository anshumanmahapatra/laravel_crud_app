import 'package:flutter/cupertino.dart';
import 'package:flutter_laravel_crud_app/services/authorization_api.dart';
import 'package:flutter_laravel_crud_app/services/storage.dart';
import 'package:flutter_laravel_crud_app/views/home.dart';
import 'package:flutter_laravel_crud_app/views/pseudo_home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../models/note_model.dart';
import '../services/notes_api.dart';

class Controller extends GetxController {
  Home home = Get.put(const Home());
  PseudoHome pseudoHome = Get.put(const PseudoHome());
  Future<List<NoteModel>>? notesData;
  Future<List<NoteModel>>? searchNotesData;

  PageController authenticationPageController = PageController();

  RxBool didChangePage = true.obs;
  RxInt errorCount = 0.obs;

  String? title, description, searchTerm;

  String? name, email, password, confirmPassword, error;

  int? id;
  int authenticationPageNumber = 0;

  RxInt searchButtonTaps = 0.obs;

  changeAuthenticationPage(int pageNo) {
    authenticationPageNumber = pageNo;
    authenticationPageController.animateToPage(authenticationPageNumber,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  didThePageChange(bool val) {
    didChangePage.value = val;
    debugPrint("Value of didChangePage: " + didChangePage.value.toString());
  }

  clearError() {
    errorCount.value = 0;
    error = "";
  }

  changeErrorValue(String val) {
    errorCount.value = errorCount.value + 1;
    error = val;
  }

  login() {
    AuthorizationApi().login(email!, password!).then((value) {
      if (value.token!.startsWith("Token")) {
        changeErrorValue(value.result!);
      } else {
        box.write('token', value.token);
        clearError();
        readNoteData();
        Get.off(() => home);
      }
    });
  }

  register() {
    AuthorizationApi()
        .register(name!, email!, password!, confirmPassword!)
        .then((value) {
      box.write('token', value.token);
      clearError();
      readNoteData();
      Get.off(() => home);
    });
  }

  logout() {
    AuthorizationApi().logout().then((value) {
      showToast(value.result);
      debugPrint("Before signing out: " + box.read("token").toString());
      box.remove("token");
      debugPrint("After signing out: " + box.read("token").toString());
      Get.off(() => pseudoHome);
    });
  }

  Future<bool> isUserLoggedIn() async {
    debugPrint("Data when first initialised: " + box.read("token").toString());
    if (box.hasData("token")) {
      return true;
    } else {
      return false;
    }
  }

  createNoteData() {
    NotesApi().postNotesApi(title!, description!).then((value) {
      showToast(value.result);
    });
  }

  readNoteData() {
    notesData = NotesApi().getNotesApi();
  }

  updateNoteData() {
    NotesApi().putNotesApi(id!, title!, description!).then((value) {
      showToast(value.result);
    });
  }

  deleteNoteData() {
    NotesApi().deleteNotesApi(id.toString()).then((value) {
      showToast(value.result);
    });
  }

  searchNoteData() {
    searchButtonTaps.value = searchButtonTaps.value + 1;
    searchNotesData = NotesApi().searchNotesApi(searchTerm!);
  }

  saveSearchTerm(String value) {
    searchTerm = value;
  }

  clearSearchTerm() {
    searchTerm = "";
  }

  saveTitle(String val) {
    title = val;
  }

  saveDescription(String val) {
    description = val;
  }

  saveId(int val) {
    id = val;
  }

  saveAuthField(int id, String val) {
    if (id == 1) {
      name = val;
    } else if (id == 2) {
      email = val;
    } else if (id == 3) {
      password = val;
    } else {
      confirmPassword = val;
    }
  }

  Future<bool> shouldPop() async {
    didThePageChange(true);
    clearSearchTerm();
    searchButtonTaps.value = 0;
    return true;
  }

  showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
    );
  }
}
