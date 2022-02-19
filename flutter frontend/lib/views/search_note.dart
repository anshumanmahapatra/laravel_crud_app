import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';

import '../models/note_model.dart';

import '../views/update_note.dart';

import '../widgets/note_widget.dart';

class SearchNote extends StatelessWidget {
  const SearchNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NoteWidget noteWidget = Get.put(NoteWidget());
    Controller controller = Get.put(Controller());

    double width = Get.mediaQuery.size.width;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return WillPopScope(
      onWillPop: controller.shouldPop,
      child: Scaffold(
          appBar: AppBar(
            title: Container(
                width: width * 0.8,
                color: Colors.white,
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    autofocus: true,
                    cursorColor: Colors.blue.shade800,
                    onSaved: (value) {
                      controller.saveSearchTerm(value!);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        controller.searchNoteData();
                      }
                    },
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search, color: Colors.green),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            controller.searchNoteData();
                          }
                        },
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                )),
            centerTitle: true,
            backgroundColor: Colors.blue.shade800,
            elevation: 0.0,
          ),
          body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(() {
                if (controller.searchButtonTaps.value > 0) {
                  return FutureBuilder<List<NoteModel>>(
                      future: controller.searchNotesData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.active ||
                            snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            debugPrint("Got error. The error is: ");
                            debugPrint(snapshot.error.toString());
                            return const Center(
                              child: Text(
                                  "Some Error occured while fetching notes"),
                            );
                          } else {
                            if (snapshot.data!.isEmpty) {
                              return Center(
                                child: Text(
                                    "No matches found for query ${controller.searchTerm}"),
                              );
                            } else {
                              return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                  ),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(() => UpdateNote(
                                              noteModel: snapshot.data![index],
                                            ));
                                      },
                                      child: noteWidget.getNoteWidget(
                                          snapshot, index),
                                    );
                                  });
                            }
                          }
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          debugPrint("Waiting for data");
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          debugPrint("Got nothing tos show");
                          return Container();
                        }
                      });
                } else {
                  return Container();
                }
              }))),
    );
  }
}
