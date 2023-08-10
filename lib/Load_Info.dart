import 'dart:convert';
import 'package:health_taylor/Info.dart';
import 'package:http/http.dart' as http;

class Load_Info {
  Future<Info> getFirstInfo() async {
    String baseUrl =
        'https://api.odcloud.kr/api/15007122/v1/uddi:95d6cbf2-f800-4ce3-a4f7-f57823274732?page=1&perPage=1&serviceKey=Vi8Aejw81hrfRkabXSzT7bsP5QGippEFyGTXCXm%2BLf9Yye0Q3R9SSvt6MsAQdpJuhi01vLpbzO9cqcstigIylQ%3D%3D';
    final http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final Map<String, dynamic> item = body['data'][0];
      Info info = Info.fromJson(item);

      return info;
    } else {
      throw Exception('Failed to load evs');
    }
  }

  Future<int> getFirstHeight() async {
    Info info = await getFirstInfo();
    return info.height; // height가 Ev 클래스의 실제 속성인 것을 가정합니다.
  }

  Future<int> getFirstWeight() async {
    Info info = await getFirstInfo();
    return info.weight; // weight가 Ev 클래스의 실제 속성인 것을 가정합니다.
  }
}
