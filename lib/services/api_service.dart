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
  static String? customerName;
  static int? customerId;
  static String? authToken;

  // Session cookie untuk menjaga session dengan backend
  static String? _sessionCookie;

  // Helper untuk menambahkan cookie ke headers
  static Map<String, String> _getHeaders({String? contentType}) {
    final headers = <String, String>{};
    if (contentType != null) {
      headers['Content-Type'] = contentType;
    }
    if (_sessionCookie != null) {
      headers['Cookie'] = _sessionCookie!;
    }
    return headers;
  }

  // Helper untuk menyimpan session cookie dari response
  static void _saveCookie(http.Response response) {
    final setCookie = response.headers['set-cookie'];
    if (setCookie != null) {
      // Ambil JSESSIONID dari cookie
      final match = RegExp(r'JSESSIONID=([^;]+)').firstMatch(setCookie);
      if (match != null) {
        _sessionCookie = match.group(1);
      }
    }
  }

  // Helper untuk menambahkan jsessionid ke URL (URL Rewriting untuk Tomcat)
  static Uri _buildUrl(String path) {
    String urlStr = '$baseUrl$path';
    
    if (_sessionCookie != null && _sessionCookie!.isNotEmpty) {
      final parts = urlStr.split('?');
      parts[0] = '${parts[0]};jsessionid=$_sessionCookie';
      urlStr = parts.join('?');
    }

    Uri uri = Uri.parse(urlStr);

    if (customerId != null) {
      final queryParams = Map<String, String>.from(uri.queryParameters);
      queryParams['customerId'] = customerId.toString();
      uri = uri.replace(queryParameters: queryParams);
    }

    return uri;
  }

  // =========================
  // CEK LOGIN STATUS
  // =========================
  static bool isLoggedIn() {
    return customerEmail != null && customerId != null;
  }

  // =========================
  // ADMIN LOGIN
  // =========================
  static Future<Map<String, dynamic>> adminLogin(
    String username,
    String password,
  ) async {
    try {
      final response = await http.post(
        _buildUrl('/auth/admin/login'),
        headers: _getHeaders(contentType: 'application/json'),
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      _saveCookie(response);

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
        _buildUrl('/auth/customer/coba/login'),
        headers: _getHeaders(
          contentType: 'application/x-www-form-urlencoded',
        ),
        body: {
          'email': email,
          'password': password,
        },
      );

      _saveCookie(response);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          customerEmail = data['email'];
          customerName = data['username'] ?? email;
          customerId = data['customerId'] is int
              ? data['customerId']
              : int.tryParse(data['customerId'].toString());

          return {
            "success": true,
            "message": data['message'] ?? "Login berhasil",
            "username": data['username'],
            "email": data['email'],
            "customerId": data['customerId'],
          };
        }

        return {
          "success": false,
          "message": data['message'] ?? "Login gagal",
        };
      }

      return {
        "success": false,
        "message": "Username atau password salah",
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
        _buildUrl('/auth/customer/coba/register/api'),
        headers: _getHeaders(
          contentType: 'application/x-www-form-urlencoded',
        ),
        body: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          "success": data['success'] ?? false,
          "message": data['message'] ?? '',
        };
      }

      return {
        "success": false,
        "message": "Registrasi gagal (${response.statusCode})",
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
        _buildUrl('/auth/admin/minuman/get'),
        headers: _getHeaders(),
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
  // CREATE MINUMAN (ADMIN)
  // =========================
  static Future<Map<String, dynamic>> createMinuman(
    String nama,
    int harga,
    String deskripsi,
    String jenis,
    String gambar,
  ) async {
    try {
      final response = await http.post(
        _buildUrl('/auth/admin/minuman/create'),
        headers: _getHeaders(contentType: 'application/json'),
        body: jsonEncode({
          'nama': nama,
          'harga': harga,
          'deskripsi': deskripsi,
          'jenis': jenis,
          'gambar': gambar,
        }),
      );

      if (response.statusCode == 200) {
        return {
          "success": true,
          "message": "Minuman berhasil ditambahkan",
        };
      }

      return {
        "success": false,
        "message": "Gagal menambahkan minuman (${response.statusCode})",
      };
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

  // =========================
  // UPDATE MINUMAN (ADMIN)
  // =========================
  static Future<Map<String, dynamic>> updateMinuman(
    int id,
    String nama,
    int harga,
    String deskripsi,
    String jenis,
    String gambar,
  ) async {
    try {
      final response = await http.put(
        _buildUrl('/auth/admin/minuman/update/$id'),
        headers: _getHeaders(contentType: 'application/json'),
        body: jsonEncode({
          'id': id,
          'nama': nama,
          'harga': harga,
          'deskripsi': deskripsi,
          'jenis': jenis,
          'gambar': gambar,
        }),
      );

      if (response.statusCode == 200) {
        return {"success": true, "message": "Minuman berhasil diupdate"};
      }
      return {"success": false, "message": "Gagal update minuman (${response.statusCode})"};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // =========================
  // DELETE MINUMAN (ADMIN)
  // =========================
  static Future<Map<String, dynamic>> deleteMinuman(int id) async {
    try {
      final response = await http.delete(
        _buildUrl('/auth/admin/minuman/delete/$id'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        return {"success": true, "message": "Minuman berhasil dihapus"};
      }
      return {"success": false, "message": "Gagal menghapus minuman (${response.statusCode})"};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // =========================
  // MIDTRANS SNAP TOKEN
  // =========================
  static Future<Map<String, dynamic>> createMidtransTransaction(
    int amount,
    String name,
    String email,
  ) async {
    try {
      final response = await http.post(
        _buildUrl('/api/payments/snap-token'),
        headers: _getHeaders(contentType: 'application/json'),
        body: jsonEncode({
          'amount': amount,
          'name': name,
          'email': email,
          'phone': '08123456789'
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          "success": true,
          "snapToken": data['snapToken'],
          "orderId": data['orderId'],
        };
      }

      return {
        "success": false,
        "message": "Gagal membuat transaksi midtrans",
      };
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

  // =========================
  // GET LAPORAN PENJUALAN
  // =========================
  static Future<List<dynamic>> getLaporanPenjualan() async {
    try {
      final response = await http.get(
        _buildUrl('/auth/admin/laporan'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return [];
    } catch (e) {
      print('Error getLaporanPenjualan: $e');
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
        _buildUrl('/auth/customer/coba/add'),
        headers: _getHeaders(
          contentType: 'application/x-www-form-urlencoded',
        ),
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
        _buildUrl('/auth/customer/cart'),
        headers: _getHeaders(),
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
        _buildUrl('/auth/customer/cart/$id'),
        headers: _getHeaders(),
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
        _buildUrl('/auth/customer/payment'),
        headers: _getHeaders(
          contentType: 'application/x-www-form-urlencoded',
        ),
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
        _buildUrl('/auth/customer/history'),
        headers: _getHeaders(),
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
  static Future<void> logout() async {
    try {
      // Hit endpoint logout untuk admin dan customer
      await http.get(_buildUrl('/auth/customer/logout'), headers: _getHeaders());
      await http.get(_buildUrl('/auth/admin/logout'), headers: _getHeaders());
    } catch (e) {
      // Ignored
    }

    customerEmail = null;
    customerName = null;
    customerId = null;
    authToken = null;
    _sessionCookie = null;
  }
}