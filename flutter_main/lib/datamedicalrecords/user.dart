import 'dart:convert';

import 'package:flutter/foundation.dart';

class MR {
  MR({
    required this.id,
    required this.pasien,
    required this.diagnosa,
    required this.treatment,
  });

  int id;
  String pasien;
  String diagnosa;
  String treatment;

  factory MR.fromJson(Map<String, dynamic> json) => MR(
    id: json["id"],
    pasien: json["pasien_id"],
    diagnosa: json["diagnosa"],
    treatment: json["treatment"],
  );
}
