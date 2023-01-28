import 'dart:html';

import 'package:crud_mysql/function/func_handleNull.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'func_isLoading.dart';

addData(context, judul, deskripsi, img) async {
  //handle data kosong
  if (judul == null || deskripsi == null || img == null) {
    handle("Semua data harus diisi!");
  } else {
    //jika data tidak kosong, loading lalu pushnamed ke fungsi read
    isLoading(context);
    String imgName = img.path.split('/').last;
    FormData sendData = FormData.fromMap({
      "judul": judul.toString(),
      "deskripsi": deskripsi.toString(),
      "url_image":
          await MultipartFile.fromFile(img.path, filename: imgName.toString()),
    });
    final response = await Dio().post(
        "https://oasis2022.000webhostapp.com/add_informasi.php",
        data: sendData);
    log("test send data:" + judul.toString());
    return Navigator.of(context)
        .pushNamedAndRemoveUntil('/read', (Route<dynamic> route) => false);
  }
}
