import 'package:flutter/material.dart';
import 'models/course.dart';
import 'widgets/course_card.dart';
import 'widgets/header_banner.dart';

void main() {
  runApp(const PoliwangiDashboardApp());
}

class PoliwangiDashboardApp extends StatefulWidget {
  const PoliwangiDashboardApp({super.key});

  @override
  State<PoliwangiDashboardApp> createState() => _PoliwangiDashboardAppState();
}

class _PoliwangiDashboardAppState extends State<PoliwangiDashboardApp> {
  // State lokal untuk beralih antara Light Mode dan Dark Mode
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard Akademik TRPL',
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0284C7),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0284C7),
          brightness: Brightness.dark,
        ),
      ),
      home: DashboardScreen(
        isDarkMode: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const DashboardScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            tooltip: 'Ganti Tema',
            onPressed: onToggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'Profil',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Navigasi ke halaman profil akan dibuat di Modul 03!',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      // ── LayoutBuilder untuk Deteksi Lebar Wadah Responsif ─────────────
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Breakpoint Material 3: jika lebar layar >= 600dp (Tablet / Landscape)
          if (constraints.maxWidth >= 600) {
            return const _WideTabletLayout();
          } else {
            return const _NarrowPhoneLayout();
          }
        },
      ),
    );
  }
}

// ── TATA LETAK 1: Smartphone (< 600 dp) — 1 Kolom Vertikal ───────────────
class _NarrowPhoneLayout extends StatelessWidget {
  const _NarrowPhoneLayout();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const HeaderBanner(),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mata Kuliah Semester 5',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              '${dummyCourses.length} Terdaftar',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Render kartu satu per satu ke bawah
        ...dummyCourses.map(
          (course) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: SizedBox(height: 170, child: CourseCard(course: course)),
          ),
        ),
      ],
    );
  }
}

// ── TATA LETAK 2: Tablet / Landscape (>= 600 dp) — 2 Kolom Grid ───────────
class _WideTabletLayout extends StatelessWidget {
  const _WideTabletLayout();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kolom Kiri: Banner & Ringkasan Profil (flex: 2)
          const Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HeaderBanner(),
                  SizedBox(height: 16),
                  _QuickActionPanel(),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),

          // Kolom Kanan: 2-Column Grid Mata Kuliah (flex: 3)
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daftar Mata Kuliah Semester 5',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 1.1,
                        ),
                    itemCount: dummyCourses.length,
                    itemBuilder: (context, index) =>
                        CourseCard(course: dummyCourses[index]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionPanel extends StatelessWidget {
  const _QuickActionPanel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aksi Cepat',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 20),
            ListTile(
              dense: true,
              leading: const Icon(Icons.upload_file, color: Color(0xFF0284C7)),
              title: const Text('Kumpul Tugas di GitHub Classroom'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {},
            ),
            ListTile(
              dense: true,
              leading: const Icon(Icons.schedule, color: Color(0xFF10B981)),
              title: const Text('Lihat Jadwal Praktikum Lab'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
