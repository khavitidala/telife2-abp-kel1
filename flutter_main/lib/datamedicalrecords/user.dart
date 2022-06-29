import 'dart:convert';

List<MR> MRsFromJson(String str) => List<MR>.from(json.decode(str).map((x) => MR.fromJson(x)));

String MRToJson(List<MR> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
    pasien: json["pasien"],
    diagnosa: json["diagnosa"],
    treatment: json["treatment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pasien": pasien,
    "diagnosa" : diagnosa,
    "treatment" : treatment,
  };
}
