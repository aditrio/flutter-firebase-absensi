class Absen {
  String key;
  String absen_id;
  String tanggal;
  String kelas;
  String mapel;
  String status;

  Absen(this.absen_id, this.tanggal, this.kelas, this.mapel, this.status);

  Absen.fromSnapshot(snapshot)
      : key = snapshot.key,
        absen_id = snapshot.value['absen_id'],
        tanggal = snapshot.value['tanggal'],
        kelas = snapshot.value['kelas'],
        mapel = snapshot.value['mapel'],
        status = snapshot.value['status'];
  toJson() {
    return {
      "absen_id": absen_id,
      "tanggal": tanggal,
      "mapel": mapel,
      "kelas": kelas,
      "status": status
    };
  }
}
