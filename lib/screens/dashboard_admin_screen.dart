import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            // GRID STATISTIK - 2 kolom kartu ringkas
            // ============================================================
            Text(
              'Ringkasan',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            _buildStatistikGrid(),

            const SizedBox(height: 32),

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

            // ============================================================
            // PESANAN TERBARU - Preview pesanan masuk terbaru
            // ============================================================
            Text(
              'Pesanan Terbaru',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            _buildRecentOrders(),
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
  // WIDGET: GridView.count (2 kolom) untuk kartu statistik
  // ============================================================
  Widget _buildStatistikGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.35,
      children: [
        // Kartu 1: Total Pesanan Masuk
        _buildStatCard(
          icon: Icons.shopping_bag,
          iconColor: const Color(0xFF60A5FA),
          bgGradient: [
            const Color(0xFF1E3A5F).withOpacity(0.5),
            const Color(0xFF111827),
          ],
          label: 'Total Pesanan',
          value: '$_totalPesanan',
          subtitle: '+12 hari ini',
          subtitleColor: const Color(0xFF4ADE80),
        ),

        // Kartu 2: Total Pendapatan
        _buildStatCard(
          icon: Icons.account_balance_wallet,
          iconColor: const Color(0xFF4ADE80),
          bgGradient: [
            const Color(0xFF14532D).withOpacity(0.4),
            const Color(0xFF111827),
          ],
          label: 'Total Pendapatan',
          value: 'Rp 12.4 Jt',
          subtitle: '+Rp 1.2Jt minggu ini',
          subtitleColor: const Color(0xFF4ADE80),
        ),

        // Kartu 3: Jumlah Produk
        _buildStatCard(
          icon: Icons.local_drink,
          iconColor: const Color(0xFFFBBF24),
          bgGradient: [
            const Color(0xFF78350F).withOpacity(0.3),
            const Color(0xFF111827),
          ],
          label: 'Jumlah Produk',
          value: '$_jumlahProduk',
          subtitle: '5 kategori',
          subtitleColor: const Color(0xFFFBBF24),
        ),

        // Kartu 4: Pelanggan Aktif
        _buildStatCard(
          icon: Icons.people,
          iconColor: const Color(0xFFC084FC),
          bgGradient: [
            const Color(0xFF581C87).withOpacity(0.3),
            const Color(0xFF111827),
          ],
          label: 'Pelanggan Aktif',
          value: '$_pelangganAktif',
          subtitle: '+8 baru',
          subtitleColor: const Color(0xFFC084FC),
        ),
      ],
    );
  }

  // ============================================================
  // WIDGET: Kartu statistik individual
  // ============================================================
  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required List<Color> bgGradient,
    required String label,
    required String value,
    required String subtitle,
    required Color subtitleColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: bgGradient,
        ),
        border: Border.all(
          color: Colors.grey.shade800.withOpacity(0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon dan label
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const Spacer(),
              // Indikator tren naik
              Icon(
                Icons.trending_up,
                color: subtitleColor.withOpacity(0.7),
                size: 18,
              ),
            ],
          ),
          // Nilai utama
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Label dan subtitle
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade400,
                  fontSize: 12,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  color: subtitleColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
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
          // Aksi 1: Kelola Menu/Produk
          _buildActionTile(
            icon: Icons.restaurant_menu,
            iconColor: const Color(0xFFFBBF24),
            title: 'Kelola Menu / Produk',
            subtitle: 'Tambah, edit, dan hapus minuman',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Navigasi ke Kelola Menu (belum diimplementasi)',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFF374151),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),

          // Garis pembatas antar aksi
          Divider(
            height: 1,
            color: Colors.grey.shade800.withOpacity(0.3),
            indent: 68,
          ),

          // Aksi 2: Kelola Pesanan Masuk
          _buildActionTile(
            icon: Icons.receipt_long,
            iconColor: const Color(0xFF60A5FA),
            title: 'Kelola Pesanan Masuk',
            subtitle: 'Lihat dan proses pesanan pelanggan',
            trailing: _buildBadge('12'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Navigasi ke Kelola Pesanan (belum diimplementasi)',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFF374151),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),

          // Garis pembatas
          Divider(
            height: 1,
            color: Colors.grey.shade800.withOpacity(0.3),
            indent: 68,
          ),

          // Aksi 3: Kelola Pelanggan
          _buildActionTile(
            icon: Icons.people_outline,
            iconColor: const Color(0xFFC084FC),
            title: 'Kelola Pelanggan',
            subtitle: 'Data pelanggan terdaftar',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Navigasi ke Kelola Pelanggan (belum diimplementasi)',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFF374151),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),

          // Garis pembatas
          Divider(
            height: 1,
            color: Colors.grey.shade800.withOpacity(0.3),
            indent: 68,
          ),

          // Aksi 4: Laporan Penjualan
          _buildActionTile(
            icon: Icons.bar_chart,
            iconColor: const Color(0xFF4ADE80),
            title: 'Laporan Penjualan',
            subtitle: 'Statistik dan grafik pendapatan',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Navigasi ke Laporan (belum diimplementasi)',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFF374151),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
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
  // WIDGET: Daftar pesanan terbaru (preview singkat)
  // ============================================================
  Widget _buildRecentOrders() {
    // Dummy data pesanan terbaru
    final recentOrders = [
      {
        'id': '#ORD-007',
        'customer': 'Daffa Rizky',
        'item': 'Es Teh Manis x3',
        'total': 36000,
        'status': 'Dikirim',
        'waktu': '5 menit lalu',
      },
      {
        'id': '#ORD-006',
        'customer': 'Andi Pratama',
        'item': 'Iced Americano x2',
        'total': 50000,
        'status': 'Disiapkan',
        'waktu': '12 menit lalu',
      },
      {
        'id': '#ORD-005',
        'customer': 'Siti Nurhaliza',
        'item': 'Matcha Latte x1',
        'total': 32000,
        'status': 'Diproses',
        'waktu': '18 menit lalu',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade800.withOpacity(0.4),
        ),
      ),
      child: Column(
        children: recentOrders.asMap().entries.map((entry) {
          final index = entry.key;
          final order = entry.value;
          final isLast = index == recentOrders.length - 1;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    // Avatar pelanggan (inisial)
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFDC2626).withOpacity(0.3),
                            const Color(0xFF7F1D1D).withOpacity(0.5),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          (order['customer'] as String)[0],
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Info pesanan
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                order['customer'] as String,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                order['waktu'] as String,
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade600,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${order['id']} · ${order['item']}',
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade400,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Rp ${(order['total'] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFFFBBF24),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  color: Colors.grey.shade800.withOpacity(0.3),
                  indent: 68,
                ),
            ],
          );
        }).toList(),
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
            onPressed: () {
              Navigator.pop(ctx);
              // Kembali ke halaman utama setelah logout
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
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
}
