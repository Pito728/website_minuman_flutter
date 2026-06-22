import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';
import 'kelola_minuman_screen.dart';

/// ============================================================
/// DASHBOARD ADMIN SCREEN
/// Halaman dashboard admin dengan ringkasan statistik,
/// grid kartu info, dan daftar aksi cepat (Quick Actions).
/// ============================================================
class DashboardAdminScreen extends StatelessWidget {
  const DashboardAdminScreen({super.key});

  // ============================================================
  // DUMMY DATA - Statistik ringkas untuk dashboard
  // ============================================================
  static const int _totalPesanan = 156;
  static const int _totalPendapatan = 12450000;
  static const int _jumlahProduk = 32;
  static const int _pelangganAktif = 89;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // ============================================================
      // APP BAR - Header dashboard dengan tombol logout
      // ============================================================
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            // Logo kecil admin
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFDC2626).withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.admin_panel_settings,
                color: Color(0xFFEF4444),
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard Admin',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'DO AND DRINKS',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFDC2626),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        // Tombol Logout
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {
                // Dialog konfirmasi logout
                _showLogoutDialog(context);
              },
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2937),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey.shade800.withOpacity(0.5),
                  ),
                ),
                child: const Icon(
                  Icons.logout,
                  color: Color(0xFFEF4444),
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ============================================================
            // HEADER SELAMAT DATANG
            // ============================================================
            _buildWelcomeHeader(),

            const SizedBox(height: 24),



            // ============================================================
            // QUICK ACTIONS - Aksi cepat untuk admin
            // ============================================================
            Text(
              'Aksi Cepat',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            _buildQuickActions(context),

            const SizedBox(height: 32),

            // Bagian bawah dibiarkan kosong agar bersih dan tidak ada data palsu/gimmick.
          ],
        ),
      ),
    );
  }

  // ============================================================
  // WIDGET: Header selamat datang dengan info tanggal
  // ============================================================
  Widget _buildWelcomeHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7F1D1D),
            Color(0xFF1F2937),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDC2626).withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang, Admin! 👋',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Senin, 16 Juni 2026',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFCA5A5),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Kelola pesanan dan pantau bisnis Anda',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Ikon dekoratif
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.local_cafe,
              color: Color(0xFFFCA5A5),
              size: 36,
            ),
          ),
        ],
      ),
    );
  }



  // ============================================================
  // WIDGET: Daftar aksi cepat (Quick Actions) dengan ListTile
  // ============================================================
  Widget _buildQuickActions(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade800.withOpacity(0.4),
        ),
      ),
      child: Column(
        children: [
          // Aksi 1: Tambah Minuman
          _buildActionTile(
            icon: Icons.add_circle_outline,
            iconColor: const Color(0xFF60A5FA),
            title: 'Tambah Minuman',
            subtitle: 'Tambahkan produk minuman baru',
            onTap: () {
              _showAddMinumanDialog(context);
            },
          ),

          // Garis pembatas
          Divider(
            height: 1,
            color: Colors.grey.shade800.withOpacity(0.3),
            indent: 68,
          ),

          // Aksi 2: Laporan Penjualan
          _buildActionTile(
            icon: Icons.bar_chart,
            iconColor: const Color(0xFF4ADE80),
            title: 'Laporan Penjualan',
            subtitle: 'Statistik dan grafik pendapatan',
            onTap: () {
              _showLaporanDialog(context);
            },
          ),

          // Garis pembatas
          Divider(
            height: 1,
            color: Colors.grey.shade800.withOpacity(0.3),
            indent: 68,
          ),

          // Aksi 3: Kelola Minuman
          _buildActionTile(
            icon: Icons.inventory_2_outlined,
            iconColor: const Color(0xFFFBBF24),
            title: 'Kelola Minuman',
            subtitle: 'Edit dan hapus data minuman',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const KelolaMinumanScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // WIDGET: ListTile kustom untuk aksi cepat
  // ============================================================
  Widget _buildActionTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Icon aksi
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 14),
              // Judul dan subjudul
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Badge atau chevron
              if (trailing != null) trailing,
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right,
                color: Colors.grey.shade600,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // WIDGET: Badge notifikasi (angka di kanan aksi)
  // ============================================================
  Widget _buildBadge(String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFDC2626),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        count,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ============================================================
  // DIALOG: Konfirmasi logout admin
  // ============================================================
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F2937),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: Text(
          'Konfirmasi Logout',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Apakah Anda yakin ingin keluar dari panel admin?',
          style: GoogleFonts.poppins(
            color: Colors.grey.shade300,
            fontSize: 14,
          ),
        ),
        actions: [
          // Tombol Batal
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Batal',
              style: GoogleFonts.poppins(
                color: Colors.grey.shade400,
              ),
            ),
          ),
          // Tombol Logout
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ApiService.logout(); // Panggil API logout untuk menghapus session
              // Kembali ke halaman utama setelah logout
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Logout',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DIALOG: Tambah Minuman
  // ============================================================
  void _showAddMinumanDialog(BuildContext context) {
    final TextEditingController namaCtrl = TextEditingController();
    final TextEditingController hargaCtrl = TextEditingController();
    final TextEditingController deskripsiCtrl = TextEditingController();
    final TextEditingController jenisCtrl = TextEditingController();
    final TextEditingController gambarCtrl = TextEditingController();
    bool isLoading = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1F2937),
            title: Text('Tambah Minuman', style: GoogleFonts.poppins(color: Colors.white)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: namaCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'Nama Minuman', labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  TextField(
                    controller: hargaCtrl,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'Harga', labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  TextField(
                    controller: deskripsiCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'Deskripsi', labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  TextField(
                    controller: jenisCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'Jenis (Kopi/Non-Kopi)', labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  TextField(
                    controller: gambarCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'URL Gambar', labelStyle: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isLoading ? null : () => Navigator.pop(ctx),
                child: Text('Batal', style: GoogleFonts.poppins(color: Colors.grey)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC2626)),
                onPressed: isLoading ? null : () async {
                  setState(() => isLoading = true);
                  final harga = int.tryParse(hargaCtrl.text) ?? 0;
                  final res = await ApiService.createMinuman(
                    namaCtrl.text,
                    harga,
                    deskripsiCtrl.text,
                    jenisCtrl.text,
                    gambarCtrl.text,
                  );
                  setState(() => isLoading = false);
                  if (res['success'] == true) {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message']), backgroundColor: Colors.green));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message']), backgroundColor: Colors.red));
                  }
                },
                child: isLoading
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Simpan', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  // ============================================================
  // DIALOG: Laporan Penjualan
  // ============================================================
  void _showLaporanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F2937),
        title: Text('Laporan Penjualan', style: GoogleFonts.poppins(color: Colors.white)),
        content: SizedBox(
          width: 400,
          height: 300,
          child: FutureBuilder<List<dynamic>>(
            future: ApiService.getLaporanPenjualan(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Colors.white));
              } else if (snapshot.hasError) {
                return const Center(child: Text('Gagal memuat laporan', style: TextStyle(color: Colors.red)));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Belum ada data penjualan', style: TextStyle(color: Colors.grey)));
              }

              final data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
                  final tanggal = item['tanggal'] ?? 'Tanggal Tidak Diketahui';
                  final total = item['total'] ?? 0;
                  return ListTile(
                    leading: const Icon(Icons.date_range, color: Colors.blueAccent),
                    title: Text(tanggal.toString(), style: const TextStyle(color: Colors.white)),
                    trailing: Text('Rp $total', style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                  );
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Tutup', style: GoogleFonts.poppins(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
