import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  List<dynamic> histories = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {

    try {

      final data = await ApiService.getHistory();

      setState(() {
        histories = data;
        isLoading = false;
      });

    } catch (e) {

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Gagal memuat riwayat: $e",
          ),
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

        centerTitle: true,

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFDC2626),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),

              child: Column(
                children: [

                  const Text(
                    "RIWAYAT PESANAN",
                    style: TextStyle(
                      color: Color(0xFFDC2626),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // EMPTY
                  if (histories.isEmpty)
                    const Text(
                      "Belum ada riwayat pesanan",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),

                  // HISTORY ITEMS
                  ...histories.asMap().entries.map((entry) {

                    final index = entry.key;
                    final history = entry.value;

                    final minuman = history['minuman'];

                    return AnimatedContainer(
                      duration: Duration(
                        milliseconds: 500 + (index * 150),
                      ),

                      margin:
                          const EdgeInsets.only(bottom: 18),

                      padding: const EdgeInsets.all(20),

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

                          // HEADER
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,

                            children: [

                              Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),

                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFFDC2626),

                                  borderRadius:
                                      BorderRadius.circular(
                                    20,
                                  ),
                                ),

                                child: Text(
                                  "#INV-${history['paymentId']}",

                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),

                              Text(
                                history['tanggal'] != null
                                    ? history['tanggal']
                                        .toString()
                                        .substring(0, 10)
                                    : '-',

                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // PRODUCT
                          Row(
                            children: [

                              Container(
                                width: 70,
                                height: 70,

                                decoration: BoxDecoration(
                                  color:
                                      Colors.grey.shade900,

                                  borderRadius:
                                      BorderRadius.circular(
                                    12,
                                  ),
                                ),

                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(
                                    12,
                                  ),

                                  child:
                                      minuman != null &&
                                              minuman[
                                                      'gambar'] !=
                                                  null
                                          ? Image.network(
                                              minuman[
                                                  'gambar'],
                                              fit: BoxFit.cover,
                                            )
                                          : const Icon(
                                              Icons.local_drink,
                                              color:
                                                  Colors.white,
                                            ),
                                ),
                              ),

                              const SizedBox(width: 18),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                  children: [

                                    Text(
                                      minuman != null
                                          ? minuman['nama']
                                          : 'Minuman',

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
                                      "Harga: IDR ${minuman?['harga'] ?? '-'}",

                                      style: const TextStyle(
                                        color:
                                            Colors.white70,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      "Metode: ${history['metodePembayaran'] ?? '-'}",

                                      style: const TextStyle(
                                        color:
                                            Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Align(
                            alignment: Alignment.centerRight,

                            child: Text(
                              "Total: IDR ${history['nominal'] != null ? (history['nominal'] / 1000).floor().toString() + 'K' : '-'}",

                              style: const TextStyle(
                                color: Color(0xFFDC2626),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  // BACK BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.grey.shade700,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),

                      child: const Text(
                        "Kembali ke Menu",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}