import 'package:flutter/material.dart';
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

  String? selectedPayment;

  final List<String> paymentMethods = [
    'Cash',
    'Credit Card',
    'Debit Card',
    'Dana',
    'Ovo',
    'Gopay',
    'Bank Transfer',
  ];

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

    final result =
        await ApiService.deleteCartItem(cartId);

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
  }

  Future<void> payNow() async {

    if (selectedPayment == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Silakan pilih metode pembayaran!",
          ),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    final result = await ApiService.savePayment(
      selectedPayment!,
      totalPrice.toInt(),
    );

    if (result['success']) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: Colors.green,
        ),
      );

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
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

                        const SizedBox(height: 30),

                        const Text(
                          "Metode Pembayaran",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        DropdownButtonFormField<String>(
                          value: selectedPayment,

                          dropdownColor:
                              const Color(0xFF1F2937),

                          style: const TextStyle(
                            color: Colors.white,
                          ),

                          decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                const Color(0xFF1F2937),

                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                          ),

                          items: paymentMethods.map((e) {

                            return DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),

                          onChanged: (value) {
                            setState(() {
                              selectedPayment = value;
                            });
                          },
                        ),

                        const SizedBox(height: 30),

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