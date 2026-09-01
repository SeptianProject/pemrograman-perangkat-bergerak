// ignore_for_file: avoid_print

void main() {
  // Soal 1: Panggil hitungLuasPersegiPanjang
  double luas = hitungLuasPersegiPanjang(10, 5);
  print('Luas: ${luas.toStringAsFixed(2)} cm²');

  // Soal 3: Buat dua objek Profil
  // TODO: buat profil1 dengan emailKampus diisi
  Profil profil1 = Profil(
    nama: 'Septian Asropik',
    nim: '362558302064',
    emailKampus: 'septianasropik@poliwangi.ac.id',
  );
  // TODO: buat profil2 tanpa emailKampus
  Profil profil2 = Profil(
    nama: 'Septian',
    nim: '362558302064',
    emailKampus: null,
  );
  // TODO: panggil tampilkanInfo() pada keduanya
  print(profil1.tampilkanInfo(profil1.nama, profil1.nim, profil1.emailKampus));
  print(profil2.tampilkanInfo(profil2.nama, profil2.nim, profil2.emailKampus));
  // TODO: cetak panjang emailKampus profil1 menggunakan ?.length
  print('Panjang email profil1: ${profil1.emailKampus?.length ?? 0}');
}

// Soal 1: Implementasikan fungsi ini
double hitungLuasPersegiPanjang(double panjang, double lebar) {
  return panjang * lebar;
}

// Soal 2: Implementasikan class ini
class Profil {
  String nama;
  String nim;
  String? emailKampus;

  Profil({required this.nama, required this.nim, this.emailKampus});

  String tampilkanInfo(String nama, String nim, String? emailKampus) {
    return "[$nim] $nama | ${emailKampus != null ? 'Email: $emailKampus' : 'belum ada email'}";
  }
}
