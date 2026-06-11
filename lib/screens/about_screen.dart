import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool mobile =
        MediaQuery.of(context).size.width < 900;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const CustomNavbar(
            currentPage: "About",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // HERO SECTION
                  Stack(
                    children: [
                      SizedBox(
                        height: mobile ? 220 : 350,
                        width: double.infinity,
                        child: Image.network(
                          "https://images.unsplash.com/photo-1495521821757-a1efb6729352?q=80&w=2070&auto=format&fit=crop",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: mobile ? 220 : 350,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: mobile ? 16 : 30,
                      vertical: mobile ? 25 : 50,
                    ),
                    child: Column(
                      children: [
                        // WHY CHOOSE OUR DRINK SECTION
                        LayoutBuilder(
                          builder: (context, constraints) {
                            bool mobile = constraints.maxWidth < 900;

                            return mobile
                                ? Column(
                                    children: [
                                      const _WhyChooseSection(),
                                      const SizedBox(height: 40),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        child: Image.asset(
                                          "assets/images/triplets.png",
                                          height: mobile ? 220 : 300,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Expanded(
                                        child: _WhyChooseSection(),
                                      ),
                                      const SizedBox(width: 60),
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                            "assets/images/triplets.png",
                                            height: 400,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                          },
                        ),
                        const SizedBox(height: 80),

                        // OUR JOURNEY SECTION
                        Column(
                          children: [
                            Text(
                              "OUR JOURNEY",
                              style: TextStyle(
                                color: const Color(0xFFC00A27),
                                fontSize: mobile ? 24 : 32,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "We started operation in 2023 and today, we are proud to share our achievements:",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 50),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                bool mobile = constraints.maxWidth < 900;

                                return mobile
                                    ? Column(
                                        children: [
                                          journeyCard(
                                            context,
                                            "Our Team",
                                            "International experience and exposure",
                                            "assets/images/hero1.png",
                                          ),
                                          const SizedBox(height: 30),
                                          journeyCard(
                                            context,
                                            "Coffee Sold",
                                            "1 million cups in year 2024",
                                            "assets/images/hero2.png",
                                          ),
                                          const SizedBox(height: 30),
                                          journeyCard(
                                            context,
                                            "Employees",
                                            "Over 500 employees",
                                            "assets/images/hero3.png",
                                          ),
                                          const SizedBox(height: 30),
                                          journeyCard(
                                            context,
                                            "Our Footprints",
                                            "More than 50 stores across 45 cities in Indonesia",
                                            "assets/images/hero4.png",
                                          ),
                                        ],
                                      )
                                    : Wrap(
                                        spacing: 30,
                                        runSpacing: 30,
                                        alignment: WrapAlignment.center,
                                        children: [
                                          SizedBox(
                                            width:
                                                (constraints.maxWidth - 90) /
                                                    2,
                                            child: journeyCard(
                                              context,
                                              "Our Team",
                                              "International experience and exposure",
                                              "assets/images/hero1.png",
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                (constraints.maxWidth - 90) /
                                                    2,
                                            child: journeyCard(
                                              context,
                                              "Coffee Sold",
                                              "1 million cups in year 2024",
                                              "assets/images/hero2.png",
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                (constraints.maxWidth - 90) /
                                                    2,
                                            child: journeyCard(
                                              context,
                                              "Employees",
                                              "Over 500 employees",
                                              "assets/images/hero3.png",
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                (constraints.maxWidth - 90) /
                                                    2,
                                            child: journeyCard(
                                              context,
                                              "Our Footprints",
                                              "More than 50 stores across 45 cities in Indonesia",
                                              "assets/images/hero4.png",
                                            ),
                                          ),
                                        ],
                                      );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 80),

                        // OUR LEADERSHIP SECTION
                        Text(
                          "Our Leadership",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFFC00A27),
                            fontSize: mobile ? 22 : 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Wrap(
                          spacing: mobile ? 10 : 20,
                          runSpacing: mobile ? 10 : 20,
                          alignment: WrapAlignment.center,
                          children: const [
                            LeaderCard(
                              name: "Gungwah",
                              role: "Co-Founder & Group CEO",
                            ),
                            LeaderCard(
                              name: "Depe",
                              role: "Co-Founder",
                            ),
                            LeaderCard(
                              name: "Pito",
                              role: "Director",
                            ),
                            LeaderCard(
                              name: "Aldi",
                              role: "Chief Technology Officer",
                            ),
                          ],
                        ),
                        const SizedBox(height: 70),

                        // FOOTER
                        const Divider(
                          color: Color(0xFFC00A27),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Informasi Layanan: +62 812-3456-7890",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: mobile ? 13 : 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "© 2023 DO AND DRINKS. All rights reserved.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: mobile ? 12 : 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget journeyCard(
    BuildContext context,
    String title,
    String subtitle,
    String imageAsset,
  ) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            imageAsset,
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _WhyChooseSection extends StatelessWidget {
  const _WhyChooseSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "WHY CHOOSE OUR DRINK?",
          style: TextStyle(
            color: Color(0xFFC00A27),
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          "We believe that every sip should provide a taste that is not only refreshing but also leaves an impression. Our drinks are crafted from high-quality ingredients, processed hygienically, and developed with unique flavor innovations to satisfy everyone's palate.",
          style: TextStyle(
            color: Colors.white70,
            height: 1.7,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "We do not just sell drinks — we serve an experience. With a commitment to flavor, customer satisfaction, and the best service, we are here as the primary choice for those of you looking for more than just a thirst quencher.",
          style: TextStyle(
            color: Colors.white70,
            height: 1.7,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class LeaderCard extends StatelessWidget {
  final String name;
  final String role;

  const LeaderCard({
    super.key,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    final bool mobile =
        MediaQuery.of(context).size.width < 900;

    return Container(
      width: mobile ? 160 : 220,
      padding: EdgeInsets.all(
        mobile ? 14 : 20,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFC00A27),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: mobile ? 28 : 35,
            backgroundColor: const Color(0xFFC00A27),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: mobile ? 30 : 40,
            ),
          ),

          SizedBox(
            height: mobile ? 10 : 15,
          ),

          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: mobile ? 14 : 16,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            role,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: mobile ? 11 : 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}