import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';

class CustomNavbar extends StatelessWidget {
  final String currentPage;

  const CustomNavbar({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final bool mobile =
        MediaQuery.of(context).size.width < 768;

    // =====================
    // MOBILE NAVBAR
    // =====================
    if (mobile) {
      return Container(
        height: 70,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        color: Colors.black,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/home',
                );
              },
              child: Text(
                "DO AND DRINKS",
                style: GoogleFonts.poppins(
                  color: const Color(0xFFC00A27),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Spacer(),

            PopupMenuButton<String>(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ),
              color: Colors.black,
              onSelected: (value) async {
                if (value == '/logout') {
                  await ApiService.logout();
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                } else {
                  Navigator.pushReplacementNamed(context, value);
                }
              },
              itemBuilder: (context) {
                final List<PopupMenuEntry<String>> items = [
                  const PopupMenuItem(
                    value: '/about',
                    child: Text('About', style: TextStyle(color: Colors.white)),
                  ),
                  const PopupMenuItem(
                    value: '/menu',
                    child: Text('Menu', style: TextStyle(color: Colors.white)),
                  ),
                  const PopupMenuItem(
                    value: '/collaboration',
                    child: Text('Collaboration', style: TextStyle(color: Colors.white)),
                  ),
                  const PopupMenuItem(
                    value: '/contact',
                    child: Text('Contact Us', style: TextStyle(color: Colors.white)),
                  ),
                  const PopupMenuItem(
                    value: '/download',
                    child: Text('Download App', style: TextStyle(color: Colors.white)),
                  ),
                ];

                if (ApiService.isLoggedIn()) {
                  items.add(
                    const PopupMenuItem(
                      value: '/cart',
                      child: Text('Cart', style: TextStyle(color: Colors.green)),
                    ),
                  );
                  items.add(
                    const PopupMenuItem(
                      value: '/history',
                      child: Text('History', style: TextStyle(color: Colors.cyan)),
                    ),
                  );
                  items.add(
                    const PopupMenuItem(
                      value: '/logout',
                      child: Text('Logout', style: TextStyle(color: Colors.red)),
                    ),
                  );
                } else {
                  items.add(
                    const PopupMenuItem(
                      value: '/admin-login',
                      child: Text('Admin Login', style: TextStyle(color: Colors.blue)),
                    ),
                  );
                  items.add(
                    const PopupMenuItem(
                      value: '/login',
                      child: Text('Customer Login', style: TextStyle(color: Colors.orange)),
                    ),
                  );
                }
                return items;
              },
            ),
          ],
        ),
      );
    }

    // =====================
    // DESKTOP NAVBAR
    // =====================
    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
      ),
      color: Colors.black,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                '/home',
              );
            },
            child: Text(
              "DO AND DRINKS",
              style: GoogleFonts.poppins(
                color: const Color(0xFFC00A27),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          const Spacer(),

          _navItem(
            context,
            "About",
            "/about",
          ),

          _navItem(
            context,
            "Menu",
            "/menu",
          ),

          _navItem(
            context,
            "Collaboration",
            "/collaboration",
          ),

          _navItem(
            context,
            "Contact Us",
            "/contact",
          ),

          const SizedBox(width: 80),

          if (ApiService.isLoggedIn()) ...[
            _outlineButton(
              "Cart",
              Colors.green,
              () {
                Navigator.pushNamed(
                  context,
                  '/cart',
                );
              },
            ),
            const SizedBox(width: 18),
            _outlineButton(
              "History",
              Colors.cyan,
              () {
                Navigator.pushNamed(
                  context,
                  '/history',
                );
              },
            ),
            const SizedBox(width: 18),
            _outlineButton(
              "Logout",
              Colors.red,
              () async {
                await ApiService.logout();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
            ),
          ] else ...[
            _outlineButton(
              "Admin Login",
              Colors.blue,
              () {
                Navigator.pushNamed(
                  context,
                  '/admin-login',
                );
              },
            ),

            const SizedBox(width: 18),

            _outlineButton(
              "Customer Login",
              Colors.orange,
              () {
                Navigator.pushNamed(
                  context,
                  '/login',
                );
              },
            ),
          ],

          const SizedBox(width: 18),

          _outlineButton(
            "Download App",
            Colors.redAccent,
            () {
              Navigator.pushNamed(
                context,
                '/download',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    String title,
    String route,
  ) {
    final bool active = currentPage == title;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(
              context,
              route,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 200,
            ),
            padding: const EdgeInsets.only(
              bottom: 5,
            ),
            decoration: BoxDecoration(
              border: active
                  ? const Border(
                      bottom: BorderSide(
                        color: Color(0xFFC00A27),
                        width: 2,
                      ),
                    )
                  : null,
            ),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                color: active
                    ? const Color(0xFFC00A27)
                    : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _outlineButton(
    String text,
    Color color,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      height: 40,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: color,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}