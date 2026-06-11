import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';
import '../utils/responsive.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool mobile = Responsive.isMobile(context);

    final products = [
      {
        "name": "ESPRESSO",
        "price": "IDR 27K",
        "image":
            "https://images.unsplash.com/photo-1485808191679-5f86510681a2?q=80&w=1287&auto=format&fit=crop",
        "desc":
            "Espresso is a strong and concentrated coffee made by forcing hot water through finely ground coffee beans.",
      },
      {
        "name": "CAPPUCCINO",
        "price": "IDR 21K",
        "image":
            "https://images.unsplash.com/photo-1557006021-b85faa2bc5e2?q=80&w=1287&auto=format&fit=crop",
        "desc":
            "Cappuccino is a popular coffee drink made with equal parts espresso, steamed milk, and milk foam.",
      },
      {
        "name": "LATTE",
        "price": "IDR 24K",
        "image":
            "https://images.unsplash.com/photo-1541167760496-1628856ab772?q=80&w=1037&auto=format&fit=crop",
        "desc":
            "Smooth coffee with creamy milk texture. Perfect for relaxing and enjoying your day.",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const CustomNavbar(
            currentPage: "Menu",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mobile ? 16 : 40,
                  vertical: mobile ? 20 : 30,
                ),
                child: Column(
                  children: [
                    SizedBox(height: mobile ? 10 : 20),

                    Text(
                      "COFFEE",
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
                      children: products.map((item) {
                        return CoffeeCard(item: item);
                      }).toList(),
                    ),

                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CoffeeCard extends StatefulWidget {
  final Map<String, String> item;

  const CoffeeCard({
    super.key,
    required this.item,
  });

  @override
  State<CoffeeCard> createState() => _CoffeeCardState();
}

class _CoffeeCardState extends State<CoffeeCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final bool mobile = Responsive.isMobile(context);

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
                  backgroundImage: NetworkImage(
                    widget.item["image"]!,
                  ),
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
                "- ${widget.item["name"]} -",
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              widget.item["desc"]!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                height: 1.6,
                fontSize: mobile ? 12 : 14,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              widget.item["price"]!,
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
                onPressed: () {},
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