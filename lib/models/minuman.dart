class Minuman {
  final int? id;
  final String nama;
  final int harga;
  final String deskripsi;
  final String jenis;
  final String gambar;

  Minuman({
    this.id,
    required this.nama,
    required this.harga,
    required this.deskripsi,
    required this.jenis,
    required this.gambar,
  });

  factory Minuman.fromJson(Map<String, dynamic> json) {
    return Minuman(
      id: json['id'] as int?,
      nama: json['nama'] ?? '',
      harga: (json['harga'] ?? 0).toInt(),
      deskripsi: json['deskripsi'] ?? '',
      jenis: json['jenis'] ?? '',
      gambar: json['gambar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
      'deskripsi': deskripsi,
      'jenis': jenis,
      'gambar': gambar,
    };
  }
}