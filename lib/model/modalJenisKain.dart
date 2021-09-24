class JenisKain {
  final String id_jenis_kain;
  final String nama_jenis_kain;
  final String satuan_kain_kg;
  final String satuan_kain_m;
  final String create_date;
  final String update_date;

  JenisKain(
    this.id_jenis_kain,
    this.nama_jenis_kain,
    this.satuan_kain_kg,
    this.satuan_kain_m,
    this.create_date,
    this.update_date,
  );

  factory JenisKain.fromJson(Map<String, dynamic> json) => JenisKain(
        json['id_jenis_kain'],
        json['nama_jenis_kain'],
        json['satuan_kain_kg'],
        json['satuan_kain_m'],
        json['create_date'],
        json['update_date'],
      );

  Map<String, dynamic> toJson() => {
        "id_jenis_kain": id_jenis_kain,
        "nama_jenis_kain": nama_jenis_kain,
        "satuan_kain_kg": satuan_kain_kg,
        "satuan_kain_m": satuan_kain_m,
        "create_date": create_date,
        "update_date": update_date,
      };
}
