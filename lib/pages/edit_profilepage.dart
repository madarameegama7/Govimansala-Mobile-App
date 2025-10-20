import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../services/auth_service.dart';
import '../services/farmer_service.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool isLoading = true;

  Map<String, dynamic>? farmer;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  // Load current profile from backend
  Future<void> loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      final decoded = JwtDecoder.decode(token);
      int userId = decoded['userId'];
      try {
        FarmerService service = FarmerService();
        final data = await service.getFarmerByUserId(userId, token);
        setState(() {
          farmer = data;
          _nameController.text = farmer!['user']?['name'] ?? '';
          _emailController.text = farmer!['user']?['email'] ?? '';
          _phoneController.text = farmer!['user']?['phone'] ?? '';
          isLoading = false;
        });
      } catch (e) {
        print("Error loading profile: $e");
        setState(() => isLoading = false);
      }
    }
  }

  // Submit updated profile to backend
  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      try {
        AuthService authService = AuthService();
        Map<String, dynamic> updatedData = {
          "name": _nameController.text,
          "email": _emailController.text,
          "phone": _phoneController.text,
        };

        final response = await authService.updateProfile(token, updatedData);
        print("Profile updated: $response");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );

        // Return updated data to ProfilePage
        Navigator.pop(context, updatedData);
      } catch (e) {
        print("Error updating profile: $e");
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Failed to update profile')));
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: "Name"),
                      validator: (val) =>
                          val == null || val.isEmpty ? "Enter name" : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: "Email"),
                      validator: (val) =>
                          val == null || val.isEmpty ? "Enter email" : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: "Phone"),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: submit,
                      child: const Text("Update Profile"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
