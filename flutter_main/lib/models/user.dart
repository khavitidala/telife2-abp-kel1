class User {
  final int id;
  final String username;
  final String password;
  final String nama;
  final String nim;
  final bool isadmin;
  final bool iskonselor;
  final bool ispasien;

  const User(
      {required this.password,
      required this.nama,
      required this.nim,
      required this.isadmin,
      required this.iskonselor,
      required this.ispasien,
      required this.id,
      required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['data']['id'],
        username: json['data']['username'],
        password: json['data']['password'],
        nama: json['data']['nama'],
        nim: json['data']['nim'],
        isadmin: json['data']['is_admin'],
        iskonselor: json['data']['is_konselor'],
        ispasien: json['data']['is_pasien']);
  }
}