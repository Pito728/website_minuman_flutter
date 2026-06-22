import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  List<dynamic> cartItems = [];

  bool isLoading = true;

  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {

    try {

      final data = await ApiService.getCart();

      double total = 0;

      for (var item in data) {

        if (item['minuman'] != null &&
            item['minuman']['harga'] != null) {

          total +=
              double.parse(
                item['minuman']['harga'].toString(),
              );
        }
      }

      setState(() {
        cartItems = data;
        totalPrice = total;
        isLoading = false;
      });

    } catch (e) {

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal memuat keranjang: $e"),
        ),
      );
    }
  }

  Future<void> deleteItem(int cartId) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F2937),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text(
          "Konfirmasi Hapus",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Apakah kamu yakin ingin menghapus minuman ini dari keranjang?",
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Batal", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(ctx); // Tutup dialog

              final result = await ApiService.deleteCartItem(cartId);

              if (!mounted) return;

              if (result['success']) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result['message']),
                    backgroundColor: Colors.green,
                  ),
                );
                loadCart();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result['message']),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> payNow() async {
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Keranjang kosong!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // 1. Dapatkan snap token dari Midtrans
    final midtransResult = await ApiService.createMidtransTransaction(
      totalPrice.toInt(),
      ApiService.customerName ?? 'Customer',
      ApiService.customerEmail ?? 'customer@mail.com',
    );

    if (midtransResult['success']) {
      final token = midtransResult['snapToken'];
      final url = Uri.parse('https://app.sandbox.midtrans.com/snap/v2/vtweb/$token');
      
      // 2. Simpan pesanan ke database lokal dengan metode "Midtrans"
      await ApiService.savePayment("Midtrans (Online)", totalPrice.toInt());

      // 3. Arahkan pengguna ke halaman pembayaran Midtrans di browser
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }

      setState(() {
        isLoading = false;
      });

      // 4. Setelah membuka tab Midtrans, arahkan user ke halaman success
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/success');
      }
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal menghubungi Midtrans: ${midtransResult['message']}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,

        title: const Text(
          "CART",
          style: TextStyle(
            color: Color(0xFFFBBF24),
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),

        centerTitle: true,

        iconTheme:
            const IconThemeData(color: Colors.white),
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFDC2626),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [

                  // TITLE
                  const Text(
                    "KERANJANG BELANJA",
                    style: TextStyle(
                      color: Color(0xFFFBBF24),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // EMPTY CART
                  if (cartItems.isEmpty)
                    const Text(
                      "Keranjang kosong",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),

                  // CART ITEMS
                  ...cartItems.map((item) {

                    final minuman = item['minuman'];

                    return Container(
                      margin:
                          const EdgeInsets.only(bottom: 20),

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: const Color(0xFF111827),

                        borderRadius:
                            BorderRadius.circular(18),

                        border: Border.all(
                          color: Colors.grey.shade800,
                        ),
                      ),

                      child: Row(
                        children: [

                          // IMAGE
                          Container(
                            width: 80,
                            height: 80,

                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(40),

                              color: Colors.grey.shade900,
                            ),

                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(40),

                              child: minuman['gambar'] != null
                                  ? Image.network(
                                      minuman['gambar'],
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(
                                      Icons.local_drink,
                                      color: Colors.white,
                                    ),
                            ),
                          ),

                          const SizedBox(width: 20),

                          // INFO
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [

                                Text(
                                  minuman['nama'] ??
                                      'Tidak diketahui',

                                  style: const TextStyle(
                                    color:
                                        Color(0xFFFBBF24),

                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  "IDR ${minuman['harga']}",

                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // DELETE BUTTON
                          ElevatedButton(
                            onPressed: () {
                              deleteItem(item['id']);
                            },

                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.red,
                            ),

                            child: const Text(
                              "Hapus",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 30),

                  // SUMMARY
                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(25),

                    decoration: BoxDecoration(
                      color: const Color(0xFF111827),

                      borderRadius:
                          BorderRadius.circular(18),

                      border: Border.all(
                        color: Colors.grey.shade800,
                      ),
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,

                          children: [

                            const Text(
                              "Total Harga:",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            Text(
                              "IDR ${(totalPrice / 1000).floor()}K",

                              style: const TextStyle(
                                color: Color(0xFFFBBF24),
                                fontSize: 28,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // PAY BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 55,

                          child: ElevatedButton(
                            onPressed: payNow,

                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFDC2626),

                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                  14,
                                ),
                              ),
                            ),

                            child: const Text(
                              "BAYAR SEKARANG",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // BACK BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 50,

                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },

                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.grey.shade700,

                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                  14,
                                ),
                              ),
                            ),

                            child: const Text(
                              "Kembali ke Menu",
                              style: TextStyle(
                                color: Colors.white,
                              ),
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
}