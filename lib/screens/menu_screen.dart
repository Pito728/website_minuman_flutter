import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';
import '../utils/responsive.dart';
import '../models/minuman.dart';
import '../services/api_service.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Future<List<Minuman>> _futureMinuman;

  @override
  void initState() {
    super.initState();
    _futureMinuman = ApiService.getAllMinuman();
  }

  Future<void> _refreshMinuman() async {
    setState(() {
      _futureMinuman = ApiService.getAllMinuman();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool mobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const CustomNavbar(
            currentPage: "Menu",
          ),
          Expanded(
            child: FutureBuilder<List<Minuman>>(
              future: _futureMinuman,
              builder: (context, snapshot) {
                // Loading state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFD4AF37),
                    ),
                  );
                }

                // Error state
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Color(0xFFD4AF37),
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Gagal memuat data minuman',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: mobile ? 14 : 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _refreshMinuman,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC00A27),
                          ),
                          child: const Text(
                            'Coba Lagi',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Empty state
                final List<Minuman> minumanList = snapshot.data ?? [];
                if (minumanList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.local_cafe_outlined,
                          color: Color(0xFFD4AF37),
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Belum ada minuman tersedia',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: mobile ? 14 : 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _refreshMinuman,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC00A27),
                          ),
                          child: const Text(
                            'Refresh',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Success state — tampilkan data dari API
                return RefreshIndicator(
                  onRefresh: _refreshMinuman,
                  color: const Color(0xFFD4AF37),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mobile ? 16 : 40,
                        vertical: mobile ? 20 : 30,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: mobile ? 10 : 20),

                          Text(
                            "OUR MENU",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFD4AF37),
                              fontSize: mobile ? 24 : 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: mobile ? 1 : 3,
                            ),
                          ),

                          SizedBox(height: mobile ? 30 : 60),

                          Wrap(
                            spacing: mobile ? 20 : 60,
                            runSpacing: mobile ? 20 : 40,
                            alignment: WrapAlignment.center,
                            children: minumanList.map((minuman) {
                              return CoffeeCard(minuman: minuman);
                            }).toList(),
                          ),

                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CoffeeCard extends StatefulWidget {
  final Minuman minuman;

  const CoffeeCard({
    super.key,
    required this.minuman,
  });

  @override
  State<CoffeeCard> createState() => _CoffeeCardState();
}

class _CoffeeCardState extends State<CoffeeCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final bool mobile = Responsive.isMobile(context);
    final minuman = widget.minuman;

    // Format harga ke IDR
    final String formattedHarga = 'IDR ${(minuman.harga / 1000).toStringAsFixed(0)}K';

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (!mobile) {
          setState(() {
            isHover = true;
          });
        }
      },
      onExit: (_) {
        if (!mobile) {
          setState(() {
            isHover = false;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: mobile ? 260 : 280,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: isHover
              ? [
                  BoxShadow(
                    color: const Color(
                      0xFFD4AF37,
                    ).withValues(alpha: 0.25),
                    blurRadius: 25,
                    spreadRadius: 3,
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            AnimatedScale(
              duration: const Duration(
                milliseconds: 300,
              ),
              scale: isHover ? 1.08 : 1,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: isHover
                      ? [
                          BoxShadow(
                            color: const Color(
                              0xFFD4AF37,
                            ).withValues(alpha: 0.4),
                            blurRadius: 30,
                            spreadRadius: 3,
                          ),
                        ]
                      : [],
                ),
                child: CircleAvatar(
                  radius: mobile ? 55 : 75,
                  backgroundImage: minuman.gambar.isNotEmpty
                      ? NetworkImage(minuman.gambar)
                      : null,
                  backgroundColor: const Color(0xFF1A1A1A),
                  child: minuman.gambar.isEmpty
                      ? const Icon(
                          Icons.local_cafe,
                          color: Color(0xFFD4AF37),
                          size: 40,
                        )
                      : null,
                ),
              ),
            ),

            SizedBox(height: mobile ? 15 : 20),

            AnimatedDefaultTextStyle(
              duration: const Duration(
                milliseconds: 300,
              ),
              style: TextStyle(
                color: isHover
                    ? Colors.white
                    : const Color(0xFFD4AF37),
                fontSize: mobile ? 14 : 16,
                fontWeight: FontWeight.bold,
              ),
              child: Text(
                "- ${minuman.nama.toUpperCase()} -",
                textAlign: TextAlign.center,
              ),
            ),

            if (minuman.jenis.isNotEmpty) ...[
              const SizedBox(height: 5),
              Text(
                minuman.jenis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.7),
                  fontSize: mobile ? 10 : 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],

            const SizedBox(height: 15),

            Text(
              minuman.deskripsi,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white70,
                height: 1.6,
                fontSize: mobile ? 12 : 14,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              formattedHarga,
              style: TextStyle(
                color: const Color(0xFFD4AF37),
                fontSize: mobile ? 18 : 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            AnimatedScale(
              duration: const Duration(
                milliseconds: 300,
              ),
              scale: isHover ? 1.08 : 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFC00A27),
                  padding: EdgeInsets.symmetric(
                    horizontal: mobile ? 16 : 20,
                    vertical: mobile ? 10 : 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  if (minuman.id != null) {
                    final result = await ApiService.addToCart(minuman.id!);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result['message'] ?? ''),
                          backgroundColor: result['success'] == true
                              ? Colors.green
                              : Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Colors.white,
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