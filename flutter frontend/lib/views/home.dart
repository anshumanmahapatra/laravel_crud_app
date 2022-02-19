import 'package:flutter/material.dart';
import 'package:flutter_laravel_crud_app/views/search_note.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';

import '../models/note_model.dart';

import '../views/add_note.dart';
import '../views/update_note.dart';

import '../widgets/note_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Controller controller = Get.put(Controller());

  @override
  void initState() {
    controller.readNoteData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AddNote addNote = Get.put(const AddNote());
    SearchNote searchNote = Get.put(const SearchNote());
    NoteWidget noteWidget = Get.put(NoteWidget());

    double width = Get.mediaQuery.size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Laravel Crud'),
          backgroundColor: Colors.blue.shade800,
          elevation: 0.0,
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(() => searchNote);
                controller.didThePageChange(false);
              },
              child: const Icon(
                Icons.search,
              ),
            ),
            SizedBox(
              width: width * 0.05,
            ),
            GestureDetector(
              onTap: () {
                controller.logout();
              },
              child: Container(
                  alignment: Alignment.center, child: const Text('Logout')),
            ),
            SizedBox(
              width: width * 0.05,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => addNote);
            controller.didThePageChange(false);
          },
          backgroundColor: Colors.blue.shade800,
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
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => UpdateNote(
                                          noteModel: snapshot.data![index],
                                        ));
                                    controller.didThePageChange(false);
                                  },
                                  child:
                                      noteWidget.getNoteWidget(snapshot, index),
                                );
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
