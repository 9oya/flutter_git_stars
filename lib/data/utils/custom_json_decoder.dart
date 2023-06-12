import 'dart:convert';

import 'package:injectable/injectable.dart';

@Injectable(as: Converter)
class CustomJsonDecoder extends Converter {
  @override
  convert(input) {
    return jsonDecode(input);
  }
}
