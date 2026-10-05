import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

Future<MultipartFile> uploadImageToApi(File image) async {
  final fileName = image.path.split('/').last;
  final extension = fileName.split('.').last.toLowerCase();

  return await MultipartFile.fromFile(
    image.path,
    filename: fileName,
    contentType: MediaType('image', extension.isEmpty ? 'jpeg' : extension),
  );
}
