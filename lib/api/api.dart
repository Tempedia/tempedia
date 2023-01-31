import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tempedia/env/env.dart';

class ApiException implements Exception {
  final int status;
  ApiException({required this.status});
}

class ApiList<T> {
  final int page;
  final int pageSize;
  final int total;
  final List<T> list;

  ApiList({
    required this.page,
    required this.pageSize,
    required this.total,
    required this.list,
  });

  factory ApiList.fromJson(
      Map<String, dynamic> data, T Function(Map<String, dynamic> data) f) {
    final List<T> l = [];
    for (var d in data['list']) {
      l.add(f(d));
    }
    return ApiList(
      list: l,
      page: data['page'],
      pageSize: data['page_size'],
      total: data['total'],
    );
  }
}

Uri apiuri(String path, {Map<String, dynamic>? queryParams}) {
  return Uri(
    scheme: env.scheme,
    port: env.apiHostPort,
    host: env.apiHost,
    path: env.apiPrefix + path,
    queryParameters: queryParams,
  );
}

Future<dynamic> apiget(String path, {Map<String, dynamic>? queryParams}) async {
  final uri = apiuri(path, queryParams: queryParams);
  final r = await http.get(uri);
  if (r.statusCode != 200) {
    throw HttpException('Network Error', uri: uri);
  }
  final json = jsonDecode(r.body);
  if (json['status'] != 0) {
    throw ApiException(status: json['status']);
  }
  // await Future.delayed(Duration(seconds: 3));
  return json['data'];
}

Future<dynamic> apipost(String path, {Map<String, dynamic>? body}) async {
  final uri = apiuri(path);
  final r = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );
  if (r.statusCode != 200) {
    throw HttpException('Network Error', uri: uri);
  }
  final json = jsonDecode(r.body);
  if (json['status'] != 0) {
    throw ApiException(status: json['status']);
  }
  // await Future.delayed(Duration(seconds: 3));
  return json['data'];
}
