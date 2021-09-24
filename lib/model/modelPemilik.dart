class Pemilik {
  final String id_pemilik;
  final String nama_pemilik;
  final String create_date;
  final String update_date;

  Pemilik(
    this.id_pemilik,
    this.nama_pemilik,
    this.create_date,
    this.update_date,
  );

  factory Pemilik.fromJson(Map<String, dynamic> json) {
    return Pemilik(
      json['id_pemilik'],
      json['nama_pemilik'],
      json['create_date'],
      json['update_date'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_pemilik": id_pemilik,
        "nama_pemilik": nama_pemilik,
        "create_date": create_date,
        "update_date": update_date,
      };
}
