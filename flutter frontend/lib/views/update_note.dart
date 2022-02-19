import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../models/note_model.dart';

import '../controller/controller.dart';

class UpdateNote extends StatelessWidget {
  final NoteModel? noteModel;
  const UpdateNote({Key? key, this.noteModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Controller controller = Get.put(Controller());

    double width = Get.mediaQuery.size.width;
    double height = Get.mediaQuery.size.height;

    String showTimeAgo() {
      String timePosted;
      DateTime parsedDate = DateTime.parse(noteModel!.created);
      DateTime now = DateTime.now();
      Duration difference = now.difference(parsedDate);
      timePosted = timeago.format(now.subtract(difference));
      return timePosted;
    }

    return WillPopScope(
      onWillPop: controller.shouldPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Note'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade800,
          elevation: 0.0,
          actions: [
            GestureDetector(
              onTap: () {
                controller.saveId(noteModel!.id);
                controller.deleteNoteData();
                controller.didThePageChange(true);
                controller.readNoteData();
                Get.back();
              },
              child: const Icon(
                Icons.delete,
              ),
            ),
            SizedBox(
              width: width * 0.05,
            )
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  controller.saveId(noteModel!.id);
                  controller.updateNoteData();
                  controller.didThePageChange(true);
                  controller.readNoteData();
                  Get.back();
                }
              },
              backgroundColor: Colors.blue.shade800,
              child:
                  const Icon(Icons.arrow_right_alt_sharp, color: Colors.white),
            ),
            SizedBox(
              height: height * 0.05,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        maxLines: 2,
                        minLines: 1,
                        initialValue: noteModel!.title,
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          hintText: "Title",
                          hintStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                        onSaved: (val) {
                          controller.saveTitle(val!);
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        maxLines: 100,
                        minLines: 1,
                        initialValue: noteModel!.description,
                        textCapitalization: TextCapitalization.sentences,
                        onSaved: (value) {
                          controller.saveDescription(value!);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                          hintText: "Description",
                          hintStyle: TextStyle(fontSize: 18),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: height * 0.05,
              width: width,
              color: Colors.blue.shade800,
              alignment: Alignment.center,
              child: Text(
                "Edited " + showTimeAgo(),
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
