import 'package:flutter/material.dart';
import 'package:flutter_laravel_crud_app/views/pseudo_home.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PseudoHome pseudoHome = Get.put(const PseudoHome());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: pseudoHome,
    );
  }
}
