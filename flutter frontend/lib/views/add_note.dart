import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';

class AddNote extends StatelessWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Controller controller = Get.put(Controller());

    double width = Get.mediaQuery.size.width;
    double height = Get.mediaQuery.size.height;

    DateTime dt = DateTime.now();
    int hour = dt.hour;
    int minute = dt.minute;

    return WillPopScope(
      onWillPop: controller.shouldPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Note'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade800,
          elevation: 0.0,
          actions: [
            GestureDetector(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  controller.createNoteData();
                  controller.didThePageChange(true);
                  controller.readNoteData();
                  Get.back();
                }
              },
              child: const Icon(
                Icons.check,
              ),
            ),
            SizedBox(
              width: width * 0.05,
            )
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
                "Edited at " + hour.toString() + ":" + minute.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
