import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class ListCloud {
  String id, judul, deskripsi, img;
  ListCloud(
      {required this.id,
      required this.judul,
      required this.deskripsi,
      required this.img});
}

Future<List<ListCloud>> read(query) async {
  List<ListCloud> dataList = <ListCloud>[];
  ListCloud tmpData;
  final response = await Dio().get(
      "https://oasis2022.000webhostapp.com/list_informasi.php",
      queryParameters: {
        "key": query.toString(),
      });
  log("test query: $query");
  log("test read data: ${response.data[0]}");
  var data = response.data;
  log("test decode: ${data[0]}");

  if (data.length == 0) {
    return dataList;
  } else {
    List<ListCloud> tdata = [];
    data.forEach((item) {
      tmpData = ListCloud(
          id: item["1"]!,
          judul: item["STTB"]!,
          deskripsi: item["STTB1"]!,
          img: item[
              "https:/oasis2022.000webhostapp.com/archive/WhatsApp Image 2021-07-15 at 05.01.23.jpeg"]!);
      dataList.add(tmpData);
    });
    return dataList;
  }
}
