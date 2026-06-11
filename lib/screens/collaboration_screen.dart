import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';
import '../utils/responsive.dart';

class CollaborationScreen extends StatelessWidget {
  const CollaborationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool mobile = Responsive.isMobile(context);

  return Scaffold(
    backgroundColor: Colors.black,
    body: Column(
      children: [
        const CustomNavbar(
          currentPage: "Collaboration",
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [

                // HERO
                Stack(
                  children: [
                    SizedBox(
                      height: mobile ? 220 : 350,
                      width: double.infinity,
                      child: Image.network(
                        "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=2070&auto=format&fit=crop",
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
                    horizontal: mobile ? 20 : 30,
                    vertical: mobile ? 20 : 30,
                  ),
                  child: Column(
                    children: [

                      SizedBox(height: mobile ? 20 : 40),

                      // TITLE
                      Text(
                        "WHY COLLABORATE WITH US?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFC00A27),
                          fontSize: mobile ? 22 : 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: mobile ? 30 : 50),

                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: [
                          buildBenefitCard(
                            context,
                            "💰",
                            "Increase in Revenue",
                            "Partnering with us can help boost your sales and expand your customer base.",
                          ),

                          buildBenefitCard(
                            context,
                            "⚙️",
                            "Brand Visibility",
                            "Displayed in our campaign and reach a wider audience.",
                          ),

                          buildBenefitCard(
                            context,
                            "🍔",
                            "Innovation",
                            "Collaborating on new products and ideas to keep customers excited.",
                          ),
                        ],
                      ),

                      SizedBox(height: mobile ? 50 : 80),

                      Text(
                        "READY TO COLLABORATE?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFC00A27),
                          fontSize: mobile ? 22 : 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        "Fill out the form below, and our team will contact you shortly.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: mobile ? 14 : 16,
                        ),
                      ),

                      SizedBox(height: mobile ? 30 : 50),

                      SizedBox(
                        width: mobile ? double.infinity : 800,
                        child: Column(
                          children: [

                            TextField(
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: "Your Name",
                                hintStyle: const TextStyle(
                                  color: Colors.white54,
                                ),
                                filled: true,
                                fillColor: const Color(0xFF1E3A5F),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            TextField(
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: "Your Email",
                                hintStyle: const TextStyle(
                                  color: Colors.white54,
                                ),
                                filled: true,
                                fillColor: const Color(0xFF1E3A5F),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            TextField(
                              maxLines: 5,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText:
                                    "Tell us about your idea",
                                hintStyle: const TextStyle(
                                  color: Colors.white54,
                                ),
                                filled: true,
                                fillColor: const Color(0xFF1E3A5F),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            SizedBox(
                              width: mobile
                                  ? double.infinity
                                  : 150,
                              child: ElevatedButton(
                                onPressed: () {},
                                style:
                                    ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(
                                    0xFFC00A27,
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: mobile ? 40 : 60),

                      const Divider(
                        color: Color(0xFFC00A27),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "collaboration@doanddrinks.com",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "© 2023 DO AND DRINKS. All rights reserved.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),

                      const SizedBox(height: 40),
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

  Widget buildBenefitCard(
  BuildContext context,
  String emoji,
  String title,
  String desc,
) {
  final bool mobile = Responsive.isMobile(context);

  return Container(
    width: mobile ? double.infinity : 320,
    constraints: const BoxConstraints(
      maxWidth: 320,
    ),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: const Color(0xFFC8AD8A),
      ),
    ),
    child: Column(
      children: [
        Text(
          emoji,
          style: TextStyle(
            fontSize: mobile ? 40 : 48,
          ),
        ),

        const SizedBox(height: 15),

        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: mobile ? 18 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          desc,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
            fontSize: mobile ? 13 : 14,
            height: 1.6,
          ),
        ),
      ],
    ),
  );
}
}