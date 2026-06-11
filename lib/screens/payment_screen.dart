import 'package:flutter/material.dart';
import '../services/api_service.dart';

class PaymentScreen extends StatefulWidget {
  final String paymentMethod;
  final int totalHarga;

  const PaymentScreen({
    super.key,
    required this.paymentMethod,
    required this.totalHarga,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  bool isLoading = false;

  Future<void> confirmPayment() async {

    setState(() {
      isLoading = true;
    });

    final result = await ApiService.savePayment(
      widget.paymentMethod,
      widget.totalHarga,
    );

    setState(() {
      isLoading = false;
    });

    if (result['success']) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.popUntil(context, (route) => route.isFirst);

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
          "PAYMENT",
          style: TextStyle(
            color: Color(0xFFFBBF24),
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),

        centerTitle: true,

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Container(
            width: 500,

            padding: const EdgeInsets.all(30),

            decoration: BoxDecoration(
              color: const Color(0xFF111827),

              borderRadius: BorderRadius.circular(20),

              border: Border.all(
                color: Colors.grey.shade800,
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                const Center(
                  child: Text(
                    "PEMBAYARAN",
                    style: TextStyle(
                      color: Color(0xFFFBBF24),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(
                      "Metode:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      widget.paymentMethod,
                      style: const TextStyle(
                        color: Color(0xFFFBBF24),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(
                      "Total Pembayaran:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "IDR ${(widget.totalHarga / 1000).floor()}K",
                      style: const TextStyle(
                        color: Color(0xFFFBBF24),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 58,

                  child: ElevatedButton(
                    onPressed:
                        isLoading ? null : confirmPayment,

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFDC2626),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                    ),

                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "KONFIRMASI PEMBAYARAN",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 52,

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
                      "Kembali ke Cart",
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
        ),
      ),
    );
  }
}

