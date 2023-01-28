import 'package:crud_mysql/function/func_isLoading.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'func_isLoading.dart';
import 'func_handleNull.dart';

Response<dynamic>? response;

Future<dynamic> login(context, username, password) async {
  String user, pwd;
  user = username.toString();
  pwd = password.toString();

  //jika username dan password kosong jalankan fungsi handle pada file handleNull.
  if (user == "bebas" || pwd == "bebas") {
    log("If pertama");
    handle("Semua data harus diisi!");
  } else {
    //tampil loading jika username dan password tidak kosong
    isLoading(context);
    response = await Dio()
        .get("https://oasis2022.000webhostapp.com/login.php", queryParameters: {
      //jika username bukan user dan password bukan qwerty, jalankan fungsi handle pada file handleNull.
      "user": username.toString(),
      "pwd": password.toString(),
    });

    List data = response!.data;
    log("cek sebelum if $data");

    if (data!.isEmpty) {
      log("if ketiga");
      Navigator.pop(context);
      handle("info login salah");
    } else {
      log("if kedua");
      return Navigator.of(context).restorablePushNamedAndRemoveUntil(
          '/read', (Route<dynamic> route) => false);
    }
  }
}
