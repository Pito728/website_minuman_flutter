import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/minuman.dart';

class ApiService {

  // =========================
  // BASE URL
  // =========================


  // CHROME / WEB
  static const String baseUrl = "http://localhost:4783";

  static String? customerEmail;
  static String? authToken;

  // =========================
  // ADMIN LOGIN
  // =========================
  static Future<Map<String, dynamic>> adminLogin(
    String username,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/admin/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        authToken = username;

        return {
          "success": true,
          "message": "Login admin berhasil",
        };
      }

      return {
        "success": false,
        "message": "Login admin gagal",
      };
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

  // =========================
  // CUSTOMER LOGIN
  // =========================
  static Future<Map<String, dynamic>> customerLogin(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/customer/coba/login'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        customerEmail = email;

        return {
          "success": true,
          "message": "Login customer berhasil",
        };
      }

      return {
        "success": false,
        "message": "Email atau password salah",
      };
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

  // =========================
  // REGISTER CUSTOMER
  // =========================
  static Future<Map<String, dynamic>> customerRegister(
    String username,
    String email,
    String password,
    String birthday,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$baseUrl/auth/customer/coba/register',
        ),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'username': username,
          'email': email,
          'password': password,
          'birthday': birthday,
        },
      );

      if (response.statusCode == 200) {
        return {
          "success": true,
          "message": "Register berhasil",
        };
      }

      return {
        "success": false,
        "message": response.body,
      };
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

  // =========================
  // GET ALL MINUMAN
  // =========================
  static Future<List<Minuman>> getAllMinuman() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/auth/admin/minuman/get',
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        return data
            .map((e) => Minuman.fromJson(e))
            .toList();
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  // =========================
  // ADD TO CART
  // =========================
  static Future<Map<String, dynamic>> addToCart(
    int id,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$baseUrl/auth/customer/coba/add',
        ),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'minumanId': id.toString(),
        },
      );

      final data = jsonDecode(response.body);

      return {
        "success": data['success'] ?? false,
        "message": data['message'] ?? '',
      };
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

  // =========================
  // GET CART
  // =========================
  static Future<List<dynamic>> getCart() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/auth/customer/cart',
        ),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  // =========================
  // DELETE CART ITEM
  // =========================
  static Future<Map<String, dynamic>> deleteCartItem(
    int id,
  ) async {
    try {
      final response = await http.delete(
        Uri.parse(
          '$baseUrl/auth/customer/cart/$id',
        ),
      );

      final data = jsonDecode(response.body);

      return {
        "success": data['success'] ?? false,
        "message": data['message'] ?? '',
      };
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

  // =========================
  // SAVE PAYMENT
  // =========================
  static Future<Map<String, dynamic>> savePayment(
    String metode,
    int nominal,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$baseUrl/auth/customer/payment',
        ),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'metode': metode,
          'nominal': nominal.toString(),
        },
      );

      final data = jsonDecode(response.body);

      return {
        "success": data['success'] ?? false,
        "message": data['message'] ?? '',
      };
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

  // =========================
  // GET HISTORY
  // =========================
  static Future<List<dynamic>> getHistory() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/auth/customer/history',
        ),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  // =========================
  // LOGOUT
  // =========================
  static void logout() {
    customerEmail = null;
    authToken = null;
  }
}