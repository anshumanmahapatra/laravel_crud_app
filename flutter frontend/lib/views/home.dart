import 'package:flutter/material.dart';
import 'package:flutter_laravel_crud_app/controller/controller.dart';
import 'package:flutter_laravel_crud_app/models/note_model.dart';
import 'package:flutter_laravel_crud_app/views/add_note.dart';
import 'package:flutter_laravel_crud_app/widgets/note_widget.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddNote addNote = Get.put(const AddNote());
    NoteWidget noteWidget = Get.put(NoteWidget());
    Controller controller = Get.put(Controller());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Laravel Crud'),
          centerTitle: true,
          backgroundColor: Colors.green,
          elevation: 0.0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => addNote);
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(() {
              if (controller.didChangePage.value == true) {
                return FutureBuilder<List<NoteModel>>(
                    future: controller.notesData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active ||
                          snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          debugPrint("Got error. The error is: ");
                          debugPrint(snapshot.error.toString());
                          return const Center(
                            child:
                                Text("Some Error occured while fetching notes"),
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
                                return noteWidget.getNoteWidget(
                                    snapshot, index);
                              });
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
            })));
  }
}
