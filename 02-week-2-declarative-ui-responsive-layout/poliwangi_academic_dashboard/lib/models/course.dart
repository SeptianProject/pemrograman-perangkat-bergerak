class Course {
  final String code;
  final String name;
  final int sks;
  final String lecturer;
  final String room;
  final double progress; // 0.0 sampai 1.0

  const Course({
    required this.code,
    required this.name,
    required this.sks,
    required this.lecturer,
    required this.room,
    required this.progress,
  });
}

// Data Dummy Mata Kuliah Semester 5 TRPL Poliwangi
const List<Course> dummyCourses = [
  Course(
    code: 'TRPL501',
    name: 'Pemrograman Perangkat Bergerak',
    sks: 4,
    lecturer: 'Sepyan Purnama Kristanto',
    room: 'Lab Komputer 3',
    progress: 0.15,
  ),
  Course(
    code: 'TRPL502',
    name: 'Arsitektur Perangkat Lunak',
    sks: 3,
    lecturer: 'Tim Dosen TRPL',
    room: 'Ruang Teori 201',
    progress: 0.20,
  ),
  Course(
    code: 'TRPL503',
    name: 'Manajemen Proyek Agile',
    sks: 3,
    lecturer: 'Tim Dosen Bisnis',
    room: 'Ruang Teori 104',
    progress: 0.10,
  ),
  Course(
    code: 'TRPL504',
    name: 'Keamanan Aplikasi Mobile & Web',
    sks: 3,
    lecturer: 'Tim Dosen Keamanan',
    room: 'Lab Jaringan',
    progress: 0.05,
  ),
];
