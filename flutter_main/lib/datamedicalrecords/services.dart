
import 'package:flutter_main/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'user.dart';

class Services {

  static Future<List<MR>> getMRs(nim) async {
    try {
      final response = await http.get(Uri.parse(APIURL+"api/medical/"+nim));
      if (response.statusCode == 200) {
        final List<MR> listMRs = MRsFromJson(response.body);
        return listMRs;
      } else {
        return List<MR>.empty();
      }
    } catch (e){
      print(e.toString());
      return List<MR>.empty();
    }
  }
}