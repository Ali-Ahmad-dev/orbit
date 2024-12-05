import 'dart:io';

import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class HrPathProvider {
  static Future<int?> downloadFile(
      {String? url,
      String? fileName,
      dynamic progressCallback,
      dynamic onDone}) async {
    final String savePath = '${await getAbsolutePath()}/$fileName';
    print('downloadFile | savePath | $savePath');
    final result = await Dio().download(
      url!,
      savePath,
      onReceiveProgress: progressCallback,
    );
    print('downloadFile | result | ${result.statusCode}');
    OpenFile.open(savePath);
    return result.statusCode;
  }

  static Future<String?> getAbsolutePath() async {
    Directory? directory;
    //Directory? directory = await DownloadsPathProvider.downloadsDirectory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
      print(directory);
    } else if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    }
    try {
      // if(Platform.isAndroid){
      //   directory = Directory('/storage/emulated/0/Download');
      // }
      final isDirectoryexists = await directory!.exists();
      //print('getAbsolutePath | isDirectoryexists | ${isDirectoryexists}');
      if (!isDirectoryexists) {
        //directory = await getExternalStorageDirectory();
        final result = await directory.create(recursive: true);
        //print('getAbsolutePath | directory | ${result.path}');
      }
    } catch (err, stack) {
      //print("getAbsolutePath | $err");
    }
    //print('getAbsolutePath | ${directory!.path}');
    return directory!.path;
  }
}
