import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text("press"),
          onPressed: () async{
            await _getCameraPermission();
          },
        ),
      ),
    );
  }

  Future<void> backupHiveBox(String boxName, String backupPath) async {

    try {
      File(boxName).copy(backupPath);
    } finally {

    }
  }

  Future<PermissionStatus> _getPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      final result = await Permission.storage.request();
      return result;
    } else {
      return status;
    }
  }

  Future<void> downloadMobileFile(String user) async {
    // log('downloading with mobile function ');
    // setState(
    //       () {
    //     // downloading = true;
    //     // filename = user.downloadFileName;
    //   },
    // );

    PermissionStatus hasPermission = await _getPermission();
    if (hasPermission != PermissionStatus.isGranted) return;

    String savePath = "/storage/emulated/0/Download/";

    print(savePath);

    // final storage = FlutterSecureStorage();

    // String? token = await storage.read(key: 'jwt');

    Dio dio = Dio();

    // dio.interceptors.add(LogInterceptor(responseBody: false));

    dio.download(
      "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
      savePath,
      options: Options(
        // headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      ),
      onReceiveProgress: (rcv, total) {
        // setState(
        //       () {
        //     received =
        //     'received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}';
        //     progress = ((rcv / total) * 100).toStringAsFixed(0);
        //   },
        // );

      },
      deleteOnError: true,
    );
    // opens the file
    //OpenFile.open("${dir.path}/$fileName", type: 'application/pdf');
  }
}