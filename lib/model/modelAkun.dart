class Akun {
  final String id;
  final String nama;
  final String email;
  final String role;
  final String notelep;
  final String fotourl;
  final String create_date;
  final String update_date;

  Akun(this.id, this.nama, this.email, this.role, this.notelep, this.fotourl,
      this.create_date, this.update_date);

  factory Akun.fromJson(Map<String, dynamic> json) {
    return Akun(
      json['id'],
      json['nama'],
      json['email'],
      json['role'],
      json['notelep'],
      json['fotourl'],
      json['create_date'],
      json['update_date'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "email": email,
        "role": role,
        "notelep": notelep,
        "fotourl": fotourl,
        "create_date": create_date,
        "update_date": update_date,
      };
}
