import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ============================================================
/// KERANJANG SCREEN (Cart Screen)
/// Halaman keranjang pesanan minuman dengan dummy data.
/// Menampilkan daftar item, kontrol kuantitas (+/-),
/// dan bar checkout di bagian bawah.
/// ============================================================
class KeranjangScreen extends StatefulWidget {
  const KeranjangScreen({super.key});

  @override
  State<KeranjangScreen> createState() => _KeranjangScreenState();
}

class _KeranjangScreenState extends State<KeranjangScreen>
    with SingleTickerProviderStateMixin {
  // ============================================================
  // DUMMY DATA - Data keranjang sementara untuk front-end
  // ============================================================
  final List<Map<String, dynamic>> _keranjangItems = [
    {
      'id': 1,
      'nama': 'Iced Americano',
      'harga': 25000,
      'gambar': null, // Dummy, menggunakan icon
      'kategori': 'Kopi',
      'qty': 2,
    },
    {
      'id': 2,
      'nama': 'Matcha Latte',
      'harga': 32000,
      'gambar': null,
      'kategori': 'Non-Kopi',
      'qty': 1,
    },
    {
      'id': 3,
      'nama': 'Brown Sugar Boba',
      'harga': 28000,
      'gambar': null,
      'kategori': 'Spesial',
      'qty': 1,
    },
    {
      'id': 4,
      'nama': 'Es Teh Manis',
      'harga': 12000,
      'gambar': null,
      'kategori': 'Teh',
      'qty': 3,
    },
    {
      'id': 5,
      'nama': 'Caramel Macchiato',
      'harga': 35000,
      'gambar': null,
      'kategori': 'Kopi',
      'qty': 1,
    },
  ];

  // Controller animasi untuk efek shimmer pada tombol checkout
  late AnimationController _animController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    // Animasi pulse halus pada tombol checkout
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  // ============================================================
  // MENGHITUNG TOTAL HARGA dari seluruh item di keranjang
  // ============================================================
  double get _totalHarga {
    double total = 0;
    for (var item in _keranjangItems) {
      total += (item['harga'] as int) * (item['qty'] as int);
    }
    return total;
  }

  // ============================================================
  // MENAMBAH KUANTITAS item
  // ============================================================
  void _tambahQty(int index) {
    setState(() {
      _keranjangItems[index]['qty']++;
    });
  }

  // ============================================================
  // MENGURANGI KUANTITAS item (minimal 1, atau hapus jika 0)
  // ============================================================
  void _kurangiQty(int index) {
    setState(() {
      if (_keranjangItems[index]['qty'] > 1) {
        _keranjangItems[index]['qty']--;
      } else {
        // Hapus item dari keranjang jika qty menjadi 0
        _keranjangItems.removeAt(index);
      }
    });
  }

  // ============================================================
  // HAPUS ITEM dari keranjang
  // ============================================================
  void _hapusItem(int index) {
    final namaItem = _keranjangItems[index]['nama'];
    setState(() {
      _keranjangItems.removeAt(index);
    });

    // Tampilkan snackbar konfirmasi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$namaItem dihapus dari keranjang',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF374151),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ============================================================
  // ICON BERDASARKAN KATEGORI minuman
  // ============================================================
  IconData _getIconKategori(String kategori) {
    switch (kategori) {
      case 'Kopi':
        return Icons.coffee;
      case 'Non-Kopi':
        return Icons.emoji_food_beverage;
      case 'Spesial':
        return Icons.star;
      case 'Teh':
        return Icons.local_cafe;
      default:
        return Icons.local_drink;
    }
  }

  // ============================================================
  // FORMAT HARGA ke Rupiah
  // ============================================================
  String _formatRupiah(double harga) {
    if (harga >= 1000) {
      final ribuan = (harga / 1000).toStringAsFixed(0);
      return 'Rp ${ribuan}K';
    }
    return 'Rp ${harga.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // ============================================================
      // APP BAR - Header keranjang
      // ============================================================
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Keranjang Pesanan',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        // Badge jumlah item di kanan atas
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFDC2626).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFDC2626).withOpacity(0.5),
                ),
              ),
              child: Text(
                '${_keranjangItems.length} item',
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFCA5A5),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),

      // ============================================================
      // BODY - Daftar item keranjang menggunakan ListView.builder
      // ============================================================
      body: _keranjangItems.isEmpty
          ? _buildEmptyCart()
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
              itemCount: _keranjangItems.length,
              itemBuilder: (context, index) {
                final item = _keranjangItems[index];
                return _buildCartItem(item, index);
              },
            ),

      // ============================================================
      // BOTTOM BAR - Total harga dan tombol Checkout
      // ============================================================
      bottomNavigationBar: _keranjangItems.isEmpty
          ? null
          : _buildBottomCheckout(),
    );
  }

  // ============================================================
  // WIDGET: Tampilan keranjang kosong
  // ============================================================
  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon keranjang kosong dengan efek glow
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1F2937),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFDC2626).withOpacity(0.1),
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Keranjang Kosong',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Yuk, tambahkan minuman favoritmu!',
            style: GoogleFonts.poppins(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 32),
          // Tombol kembali ke menu
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.restaurant_menu),
            label: const Text('Lihat Menu'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // WIDGET: Card item keranjang
  // Berisi gambar dummy, nama, harga, dan tombol +/- kuantitas
  // ============================================================
  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    final int qty = item['qty'];
    final int harga = item['harga'];
    final int subtotal = harga * qty;

    return Dismissible(
      key: Key('cart_${item['id']}'),
      direction: DismissDirection.endToStart,
      // Aksi hapus saat di-swipe
      onDismissed: (_) => _hapusItem(index),
      background: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFDC2626),
          borderRadius: BorderRadius.circular(18),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 30),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade800.withOpacity(0.5)),
          // Efek glow halus di sisi kiri (aksen merah)
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFDC2626).withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(-3, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            // ---- GAMBAR / ICON DUMMY ----
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFDC2626).withOpacity(0.2),
                    const Color(0xFF7F1D1D).withOpacity(0.3),
                  ],
                ),
              ),
              child: Icon(
                _getIconKategori(item['kategori']),
                color: const Color(0xFFFCA5A5),
                size: 32,
              ),
            ),

            const SizedBox(width: 14),

            // ---- INFO MINUMAN (nama, harga, subtotal) ----
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['nama'],
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp ${harga.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Subtotal per item
                  Text(
                    'Subtotal: Rp ${subtotal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFBBF24),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // ---- KONTROL KUANTITAS (+/-) ----
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade700.withOpacity(0.5),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tombol kurangi (-)
                  InkWell(
                    onTap: () => _kurangiQty(index),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(12),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        qty > 1 ? Icons.remove : Icons.delete_outline,
                        color: const Color(0xFFDC2626),
                        size: 20,
                      ),
                    ),
                  ),

                  // Jumlah kuantitas
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      '$qty',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Tombol tambah (+)
                  InkWell(
                    onTap: () => _tambahQty(index),
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(12),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.add,
                        color: Color(0xFFDC2626),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // WIDGET: Bottom bar checkout dengan total harga dan tombol
  // ============================================================
  Widget _buildBottomCheckout() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        border: Border(
          top: BorderSide(color: Colors.grey.shade800.withOpacity(0.5)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // ---- TOTAL HARGA ----
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Harga',
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade400,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Rp ${_totalHarga.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFBBF24),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // ---- TOMBOL CHECKOUT ----
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: child,
                );
              },
              child: ElevatedButton.icon(
                onPressed: () {
                  // Placeholder aksi checkout
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Checkout berhasil! Total: ${_formatRupiah(_totalHarga)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green.shade700,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_bag_outlined, size: 20),
                label: Text(
                  'Checkout',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 8,
                  shadowColor: const Color(0xFFDC2626).withOpacity(0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
