import 'dart:io' as io;

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http;
import 'package:injectable/injectable.dart';

@Injectable(as: http.Client)
class CustomHttpClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return http.IOClient(io.HttpClient()).send(request);
  }
}
