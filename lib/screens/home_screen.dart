import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/custom_navbar.dart';

class HomeScreen extends StatefulWidget {
  final String userType;

  const HomeScreen({
    super.key,
    required this.userType,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> heroImages = [
    'assets/images/hero1.png',
    'assets/images/hero2.png',
    'assets/images/hero3.png',
    'assets/images/hero4.png',
  ];

  final List<Map<String, String>> foreNews = [
    {
      'image': 'assets/images/raisa x do and drinks.png',
    },
    {
      'image': 'assets/images/do and drinks 4.png',
    },
    {
      'image': 'assets/images/do and drinks 5.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool mobile =
        MediaQuery.of(context).size.width < 900;
  return Scaffold(
    backgroundColor: Colors.black,
    body: Column(
      children: [
        CustomNavbar(
          currentPage: "Menu",
        ),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [

                // HERO SECTION
                CarouselSlider(
                  options: CarouselOptions(
                    height: mobile ? 220 : MediaQuery.of(context).size.height * 0.9,
                    autoPlay: true,
                    enlargeCenterPage: false,
                    viewportFraction: 1,
                  ),
                  items: heroImages.map((image) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          image,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    );
                  }).toList(),
                ),

                const SizedBox(height: 60),

                // OUR STORY
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "OUR STORY",
                        style: TextStyle(
                          color: Color(0xFFC00A27),
                          fontSize: mobile ? 24 : 34,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 40),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          bool mobile =
                              constraints.maxWidth < 800;

                          return mobile
                              ? Column(
                                  children: [
                                    _storyText(context),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    _storyImage(),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: _storyText(context),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Expanded(
                                      child: _storyImage(),
                                    ),
                                  ],
                                );
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: mobile ? 40 : 80,
                ),

                // OUR LIFE
                Container(
                  width: double.infinity,
                  color: Colors.black,
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Text(
                        "OUR LIFE",
                        style: TextStyle(
                          color: Color(0xFFC00A27),
                          fontSize: mobile ? 24 : 34,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "Our activities and innovations reflect our commitment to quality and society.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 50),

                      Wrap(
                        spacing: 25,
                        runSpacing: 25,
                        alignment: WrapAlignment.center,
                        children: [
                          _lifeCard(
                            image:
                                'https://images.unsplash.com/photo-1702430179297-4d9825e4b827?q=80&w=1932&auto=format&fit=crop',
                            title: 'CRAFT DRINKS',
                            desc:
                                'Innovative drinks that combine local ingredients with modern techniques.',
                          ),

                          _lifeCard(
                            image:
                                'https://images.unsplash.com/photo-1619918456538-df5b5290950b?q=80&w=2070&auto=format&fit=crop',
                            title: 'SUSTAINABILITY',
                            desc:
                                'Supporting local farmers and sustainable production methods.',
                          ),

                          _lifeCard(
                            image:
                                'https://images.unsplash.com/photo-1583555821373-16f43aae6b41?q=80&w=2070&auto=format&fit=crop',
                            title: 'EXPERIENCE',
                            desc:
                                'Creating a space that celebrates Indonesian beverage culture.',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: mobile ? 40 : 80,
                ),

                // FORENEWS
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "FORENEWS",
                        style: TextStyle(
                          color: Color(0xFFC00A27),
                          fontSize: mobile ? 24 : 36,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                        ),
                      ),

                      const SizedBox(height: 50),

                      Wrap(
                        spacing: 25,
                        runSpacing: 25,
                        alignment: WrapAlignment.center,
                        children: foreNews.map((item) {
                          return Transform.rotate(
                            angle: mobile ? 0 : 0.05,
                            child: Container(
                              width: mobile ? 260 : 320,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(20),
                                border: Border.all(
                                  color:
                                      const Color(0xFFC8AD8A),
                                  width: 3,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(18),
                                child: Image.asset(
                                  item['image']!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: mobile ? 40 : 80,
                ),

                // FOOTER
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFFC00A27),
                      ),
                    ),
                  ),
                  child: Column(
                    children: const [
                      Text(
                        "Informasi Layanan:",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "+62 812-3456-7890",
                        style: TextStyle(
                          color: Color(0xFFC00A27),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 20),

                      Text(
                        "© 2023 DO AND DRINKS. All rights reserved.",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
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
}

   Widget _storyText(BuildContext context) {
    final bool mobile =
        MediaQuery.of(context).size.width < 900;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Since 2023, we've been passionate about bringing quality beverages to Indonesia's modern lifestyle.",
          style: TextStyle(
            color: Colors.white,
            fontSize: mobile ? 15 : 18,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Our products are carefully crafted in-house, from refreshing drinks to unique collaborations.",
          style: TextStyle(
            color: Colors.white70,
            fontSize: mobile ? 14 : 17,
            height: 1.8,
          ),
        ),
      ],
    );
  }

  Widget _storyImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/images/kopi.png',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _lifeCard({
    required String image,
    required String title,
    required String desc,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool mobile = constraints.maxWidth < 900;

        return Container(
          width: mobile ? 260 : 320,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFC00A27),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              mobile ? 12 : 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    image,
                    height: mobile ? 160 : 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: mobile ? 12 : 20,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFFC8AD8A),
                    fontSize: mobile ? 18 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: mobile ? 10 : 15,
                ),
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.white70,
                    height: 1.6,
                    fontSize: mobile ? 13 : 15,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
