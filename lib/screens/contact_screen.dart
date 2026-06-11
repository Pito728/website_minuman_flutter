import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_navbar.dart';
import '../utils/responsive.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _nameController =
      TextEditingController();
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _messageController =
      TextEditingController();

  Future<void> _openMap() async {
    final Uri url = Uri.parse(
      'https://maps.google.com/?q=Universitas+Telkom',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  void _sendMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pesan berhasil dikirim'),
        backgroundColor: Colors.red,
      ),
    );

    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  @override
Widget build(BuildContext context) {
  final bool mobile = Responsive.isMobile(context);

  return Scaffold(
    backgroundColor: Colors.black,
    body: Column(
      children: [
        const CustomNavbar(
          currentPage: "Contact Us",
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: mobile ? 20 : 40),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: mobile ? 15 : 40,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(
                      mobile ? 20 : 40,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFC00A27),
                          Color(0xFF7A0A1F),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius:
                          BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFFD4AF37),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'NAME',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),

                        const SizedBox(height: 12),

                        TextField(
                          controller: _nameController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Your full name',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(10),
                            ),
                            enabledBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(
                                color: Color(0xFFD4AF37),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'EMAIL',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),

                        const SizedBox(height: 12),

                        TextField(
                          controller: _emailController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Your email address',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(10),
                            ),
                            enabledBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(
                                color: Color(0xFFD4AF37),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'MESSAGE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),

                        const SizedBox(height: 12),

                        TextField(
                          controller: _messageController,
                          maxLines: mobile ? 4 : 6,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText:
                                'Your message here...',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(10),
                            ),
                            enabledBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(
                                color: Color(0xFFD4AF37),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        Center(
                          child: SizedBox(
                            width: mobile ? double.infinity : null,
                            child: ElevatedButton(
                              onPressed: _sendMessage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(
                                        0xFFD4AF37),
                                foregroundColor:
                                    Colors.black,
                                padding:
                                    EdgeInsets.symmetric(
                                  horizontal:
                                      mobile ? 0 : 50,
                                  vertical: 14,
                                ),
                              ),
                              child: const Text(
                                'SEND MESSAGE',
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: mobile ? 30 : 50),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: mobile ? 15 : 20,
                  ),
                  child: GestureDetector(
                    onTap: _openMap,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(15),
                      child: Container(
                        height: mobile ? 220 : 350,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(
                                0xFFD4AF37),
                            width: 2,
                          ),
                        ),
                        child: Image.network(
                          'https://maps.googleapis.com/maps/api/staticmap?center=Universitas+Telkom,+Bandung&zoom=15&size=800x400&key=AIzaSyDummy',
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) {
                            return const Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 50,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Universitas Telkom',
                                    style: TextStyle(
                                      color:
                                          Colors.white,
                                      fontSize: 22,
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Tap to open Maps',
                                    style: TextStyle(
                                      color: Colors
                                          .white70,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: mobile ? 30 : 50),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(
                    mobile ? 15 : 24,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFFC00A27),
                      ),
                    ),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'Informasi Layanan:',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '+62 812-3456-7890',
                        style: TextStyle(
                          color: Color(0xFFC00A27),
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '© 2023 DO AND DRINKS. All rights reserved.',
                        style: TextStyle(
                          color: Colors.grey,
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
}
