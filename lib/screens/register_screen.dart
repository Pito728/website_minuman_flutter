import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _usernameController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _birthdayController =
      TextEditingController();

  DateTime? _selectedDate;

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  bool _isLoading = false;

  Future<void> _register() async {

    if (_passwordController.text !=
        _confirmPasswordController.text) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password tidak sama"),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    setState(() {
      _isLoading = true;
    });

    final result = await ApiService.customerRegister(
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
      _birthdayController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (result['success']) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickDate() async {

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF111827),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 430,
            margin: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: const Color(0xFF1F2937),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: Column(
              children: [

                // HEADER
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),

                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),

                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF111827),
                        Color(0xFF7F1D1D),
                      ],
                    ),
                  ),

                  child: Column(
                    children: const [

                      Icon(
                        Icons.local_bar,
                        color: Color(0xFFEF4444),
                        size: 60,
                      ),

                      SizedBox(height: 15),

                      Text(
                        "Create Your Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Join Do and Drinks for exclusive offers",
                        style: TextStyle(
                          color: Color(0xFFFCA5A5),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // FORM
                Padding(
                  padding: const EdgeInsets.all(25),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      // FULL NAME
                      const Text(
                        "Full Name",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: _usernameController,

                        style: const TextStyle(
                          color: Colors.white,
                        ),

                        decoration: InputDecoration(
                          hintText: "Nama Anda",
                          hintStyle:
                              const TextStyle(color: Colors.grey),

                          filled: true,
                          fillColor: const Color(0xFF374151),

                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color(0xFFEF4444),
                          ),

                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // EMAIL
                      const Text(
                        "Email Address",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: _emailController,

                        style: const TextStyle(
                          color: Colors.white,
                        ),

                        decoration: InputDecoration(
                          hintText: "your@email.com",
                          hintStyle:
                              const TextStyle(color: Colors.grey),

                          filled: true,
                          fillColor: const Color(0xFF374151),

                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color(0xFFEF4444),
                          ),

                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // PASSWORD
                      const Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: _passwordController,
                        obscureText: _isPasswordHidden,

                        style: const TextStyle(
                          color: Colors.white,
                        ),

                        decoration: InputDecoration(
                          hintText: "••••••••",
                          hintStyle:
                              const TextStyle(color: Colors.grey),

                          filled: true,
                          fillColor: const Color(0xFF374151),

                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color(0xFFEF4444),
                          ),

                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),

                            onPressed: () {
                              setState(() {
                                _isPasswordHidden =
                                    !_isPasswordHidden;
                              });
                            },
                          ),

                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Minimum 8 characters",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // CONFIRM PASSWORD
                      const Text(
                        "Confirm Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller:
                            _confirmPasswordController,

                        obscureText:
                            _isConfirmPasswordHidden,

                        style: const TextStyle(
                          color: Colors.white,
                        ),

                        decoration: InputDecoration(
                          hintText: "••••••••",
                          hintStyle:
                              const TextStyle(color: Colors.grey),

                          filled: true,
                          fillColor: const Color(0xFF374151),

                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color(0xFFEF4444),
                          ),

                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),

                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordHidden =
                                    !_isConfirmPasswordHidden;
                              });
                            },
                          ),

                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // DATE PICKER
                      const Text(
                        "Date of Birth",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: _pickDate,

                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 18,
                          ),

                          decoration: BoxDecoration(
                            color: const Color(0xFF374151),
                            borderRadius:
                                BorderRadius.circular(12),
                          ),

                          child: Row(
                            children: [

                              const Icon(
                                Icons.calendar_month,
                                color: Color(0xFFEF4444),
                              ),

                              const SizedBox(width: 12),

                              Text(
                                _selectedDate == null
                                    ? "Select date"
                                    : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",

                                style: TextStyle(
                                  color: _selectedDate == null
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // REGISTER BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 55,

                        child: ElevatedButton.icon(
                          onPressed:
                              _isLoading ? null : _register,

                          icon: const Icon(Icons.person_add),

                          label: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Create Account",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFDC2626),

                            foregroundColor: Colors.white,

                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // LOGIN LINK
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [

                          const Text(
                            "Already have an account? ",
                            style:
                                TextStyle(color: Colors.grey),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },

                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                color: Color(0xFFEF4444),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}