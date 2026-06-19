import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ============================================================
/// RIWAYAT PESANAN SCREEN (Order History Screen)
/// Halaman riwayat pesanan dengan 2 tab:
/// "Pesanan Aktif" dan "Selesai".
/// Menampilkan kartu riwayat dengan ID pesanan, tanggal,
/// total pembayaran, dan Chip status berwarna.
/// ============================================================
class RiwayatPesananScreen extends StatelessWidget {
  const RiwayatPesananScreen({super.key});

  // ============================================================
  // DUMMY DATA - Pesanan aktif (sedang diproses)
  // ============================================================
  static final List<Map<String, dynamic>> _pesananAktif = [
    {
      'id': '#ORD-001',
      'tanggal': '16 Juni 2026, 14:30',
      'items': ['Iced Americano x2', 'Matcha Latte x1'],
      'total': 82000,
      'status': 'Diproses',
      'metodeBayar': 'Gopay',
    },
    {
      'id': '#ORD-004',
      'tanggal': '16 Juni 2026, 15:45',
      'items': ['Caramel Macchiato x1', 'Brown Sugar Boba x2'],
      'total': 91000,
      'status': 'Disiapkan',
      'metodeBayar': 'Dana',
    },
    {
      'id': '#ORD-007',
      'tanggal': '16 Juni 2026, 16:10',
      'items': ['Es Teh Manis x3'],
      'total': 36000,
      'status': 'Dikirim',
      'metodeBayar': 'Cash',
    },
  ];

  // ============================================================
  // DUMMY DATA - Pesanan selesai
  // ============================================================
  static final List<Map<String, dynamic>> _pesananSelesai = [
    {
      'id': '#ORD-002',
      'tanggal': '15 Juni 2026, 10:00',
      'items': ['Cappuccino x1', 'Croissant x1'],
      'total': 52000,
      'status': 'Selesai',
      'metodeBayar': 'OVO',
    },
    {
      'id': '#ORD-003',
      'tanggal': '14 Juni 2026, 09:15',
      'items': ['Lemon Tea x2'],
      'total': 30000,
      'status': 'Selesai',
      'metodeBayar': 'Cash',
    },
    {
      'id': '#ORD-005',
      'tanggal': '13 Juni 2026, 18:20',
      'items': ['Mocha Frappe x1', 'Vanilla Latte x1'],
      'total': 68000,
      'status': 'Selesai',
      'metodeBayar': 'Bank Transfer',
    },
    {
      'id': '#ORD-006',
      'tanggal': '12 Juni 2026, 11:30',
      'items': ['Iced Americano x3', 'Es Teh Manis x2'],
      'total': 99000,
      'status': 'Selesai',
      'metodeBayar': 'Credit Card',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // ============================================================
    // DefaultTabController dengan 2 tab
    // ============================================================
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,

        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Riwayat Pesanan',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          // ============================================================
          // TAB BAR - Pesanan Aktif & Selesai
          // ============================================================
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: const Color(0xFFDC2626),
                  borderRadius: BorderRadius.circular(12),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey.shade400,
                labelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                dividerColor: Colors.transparent,
                labelPadding: EdgeInsets.zero,
                tabs: [
                  // Tab Pesanan Aktif dengan badge jumlah
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.access_time, size: 18),
                        const SizedBox(width: 6),
                        const Text('Pesanan Aktif'),
                        const SizedBox(width: 6),
                        // Badge jumlah pesanan aktif
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFBBF24),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${_pesananAktif.length}',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Tab Selesai
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle_outline, size: 18),
                        const SizedBox(width: 6),
                        const Text('Selesai'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // ============================================================
        // TAB BAR VIEW - Konten masing-masing tab
        // ============================================================
        body: TabBarView(
          children: [
            // Tab 1: Pesanan Aktif
            _buildPesananList(_pesananAktif, isAktif: true),
            // Tab 2: Pesanan Selesai
            _buildPesananList(_pesananSelesai, isAktif: false),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // WIDGET: Daftar pesanan dalam ListView
  // ============================================================
  Widget _buildPesananList(
    List<Map<String, dynamic>> pesananList, {
    required bool isAktif,
  }) {
    if (pesananList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isAktif ? Icons.hourglass_empty : Icons.receipt_long,
              size: 70,
              color: Colors.grey.shade700,
            ),
            const SizedBox(height: 16),
            Text(
              isAktif
                  ? 'Belum ada pesanan aktif'
                  : 'Belum ada pesanan selesai',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pesananList.length,
      itemBuilder: (context, index) {
        final pesanan = pesananList[index];
        return _buildPesananCard(pesanan, index);
      },
    );
  }

  // ============================================================
  // WIDGET: Card pesanan individual
  // Menampilkan ID, tanggal, item, total, dan Chip status
  // ============================================================
  Widget _buildPesananCard(Map<String, dynamic> pesanan, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade800.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ---- HEADER: ID Pesanan, Tanggal, dan Chip Status ----
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF1F2937),
                  const Color(0xFF111827),
                ],
              ),
            ),
            child: Row(
              children: [
                // Icon pesanan
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDC2626).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.receipt_long,
                    color: Color(0xFFEF4444),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),

                // ID Pesanan dan tanggal
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pesanan['id'],
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        pesanan['tanggal'],
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // Chip status pesanan dengan warna dinamis
                _buildStatusChip(pesanan['status']),
              ],
            ),
          ),

          // ---- KONTEN: Daftar item dan metode pembayaran ----
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Column(
              children: [
                // Daftar item yang dipesan
                ...(pesanan['items'] as List<String>).map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDC2626),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          item,
                          style: GoogleFonts.poppins(
                            color: Colors.grey.shade300,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // ---- FOOTER: Metode bayar dan total pembayaran ----
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade800.withOpacity(0.3),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Metode pembayaran
                Row(
                  children: [
                    Icon(
                      Icons.payment,
                      color: Colors.grey.shade500,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      pesanan['metodeBayar'],
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade400,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                // Total pembayaran
                Text(
                  'Rp ${(pesanan['total'] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFBBF24),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // WIDGET: Chip status pesanan dengan warna sesuai kondisi
  // Kuning = Diproses, Biru = Disiapkan, Oranye = Dikirim,
  // Hijau = Selesai
  // ============================================================
  Widget _buildStatusChip(String status) {
    Color chipColor;
    Color textColor;
    IconData chipIcon;

    switch (status) {
      case 'Diproses':
        chipColor = const Color(0xFFFBBF24).withOpacity(0.15);
        textColor = const Color(0xFFFBBF24);
        chipIcon = Icons.hourglass_bottom;
        break;
      case 'Disiapkan':
        chipColor = const Color(0xFF3B82F6).withOpacity(0.15);
        textColor = const Color(0xFF60A5FA);
        chipIcon = Icons.blender;
        break;
      case 'Dikirim':
        chipColor = const Color(0xFFF97316).withOpacity(0.15);
        textColor = const Color(0xFFFB923C);
        chipIcon = Icons.delivery_dining;
        break;
      case 'Selesai':
        chipColor = const Color(0xFF22C55E).withOpacity(0.15);
        textColor = const Color(0xFF4ADE80);
        chipIcon = Icons.check_circle;
        break;
      default:
        chipColor = Colors.grey.withOpacity(0.15);
        textColor = Colors.grey;
        chipIcon = Icons.info_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(chipIcon, color: textColor, size: 14),
          const SizedBox(width: 5),
          Text(
            status,
            style: GoogleFonts.poppins(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
