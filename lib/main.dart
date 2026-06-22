import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/history_screen.dart';
import 'screens/about_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/collaboration_screen.dart';
import 'screens/download_screen.dart';
import 'screens/transaction_success_screen.dart';

// Halaman baru
import 'screens/keranjang_screen.dart';
import 'screens/riwayat_pesanan_screen.dart';
import 'screens/login_admin_screen.dart';
import 'screens/dashboard_admin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _userType;

  // LOGIN SUCCESS
  void _handleLoginSuccess(String userType) {
    setState(() {
      _userType = userType;
    });
  }

  // LOGOUT
  void _handleLogout() {
    setState(() {
      _userType = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DO AND DRINKS',

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,

        fontFamily: GoogleFonts.poppins().fontFamily,

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC00A27),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),

        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),

      // HOME SCREEN
      home: HomeScreen(userType: 'customer'),

      // ROUTES
      routes: {
        '/login': (context) => LoginScreen(
              onLoginSuccess: _handleLoginSuccess,
            ),

        '/register': (context) => const RegisterScreen(),

        '/home': (context) => HomeScreen(
              userType: _userType ?? 'customer',
            ),

        '/menu': (context) => const MenuScreen(),

        '/cart': (context) => const CartScreen(),

        '/payment': (context) => PaymentScreen(
            paymentMethod: 'Cash',
            totalHarga: 71000,
          ),

        '/history': (context) => const HistoryScreen(),

        '/about': (context) => const AboutScreen(),

        '/contact': (context) => const ContactScreen(),

        '/collaboration': (context) => const CollaborationScreen(),

        '/download': (context) => const DownloadScreen(),

        // Route halaman baru
        '/success': (context) => const TransactionSuccessScreen(),
        '/keranjang': (context) => const KeranjangScreen(),
        '/riwayat-pesanan': (context) => const RiwayatPesananScreen(),
        '/admin-login': (context) => const LoginAdminScreen(),
        '/admin-dashboard': (context) => const DashboardAdminScreen(),
      },
    );
  }
}