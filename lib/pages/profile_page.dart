import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:govimansala/pages/orders_page.dart';
import 'package:govimansala/pages/farmer_products/my_products_page.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/farmer_service.dart';
import 'package:govimansala/pages/edit_profilepage.dart'; // import your EditProfilePage

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? farmer;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFarmer();
  }

  Future<void> fetchFarmer() async {
    setState(() => isLoading = true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      Map<String, dynamic> decoded = JwtDecoder.decode(token);
      int userId = decoded['userId'];

      try {
        FarmerService service = FarmerService();
        final data = await service.getFarmerByUserId(userId, token);
        setState(() {
          farmer = data;
          isLoading = false;
        });
      } catch (e) {
        print('Error fetching profile: $e');
        setState(() => isLoading = false);
      }
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );
    }

    if (farmer == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Theme.of(context).colorScheme.error),
              const SizedBox(height: 16),
              const Text("No Profile Found"),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: fetchFarmer, child: const Text("Retry")),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header Section
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    Theme.of(context).colorScheme.primary.withOpacity(0.05),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 30),
                child: Column(
                  children: [
                    // Profile Avatar
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundImage: NetworkImage(
                          farmer!['profileImage'] ?? 'https://via.placeholder.com/150',
                        ),
                        onBackgroundImageError: (_, __) {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      farmer!['user']?['name'] ?? 'Unknown',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.email_outlined, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          farmer!['user']?['email'] ?? '',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Farm Type & Location
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildInfoChip(
                            context,
                            icon: Icons.agriculture_outlined,
                            text: '${farmer!['farmType'] ?? 'N/A'} Farm',
                          ),
                          const SizedBox(width: 12),
                          _buildInfoChip(
                            context,
                            icon: Icons.location_on_outlined,
                            text: farmer!['location'] ?? 'N/A',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Menu Options
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 2,
                child: Column(
                  children: [
                    _buildMenuTile(
                      context,
                      icon: IconlyLight.bag,
                      title: "My Orders",
                      subtitle: "View your order history",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const OrdersPage()),
                        );
                      },
                    ),
                    Divider(height: 1, color: Theme.of(context).dividerColor.withOpacity(0.3)),
                    _buildMenuTile(
                      context,
                      icon: IconlyLight.buy,
                      title: "My Products",
                      subtitle: "Manage your products",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyProductsPage()),
                        );
                      },
                    ),
                    Divider(height: 1, color: Theme.of(context).dividerColor.withOpacity(0.3)),
                    _buildMenuTile(
                      context,
                      icon: Icons.edit,
                      title: "Edit Profile",
                      subtitle: "Update your personal information",
                      onTap: () async {
                        final updated = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditProfilePage()),
                        );

                        if (updated != null) {
                          setState(() {
                            farmer!['user']?['name'] = updated['name'];
                            farmer!['user']?['email'] = updated['email'];
                            farmer!['user']?['phone'] = updated['phone'];
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 2,
                child: _buildMenuTile(
                  context,
                  icon: IconlyLight.logout,
                  title: "Logout",
                  subtitle: "Sign out of your account",
                  isLogout: true,
                  onTap: () async {
                    final shouldLogout = await _showLogoutConfirmation(context);
                    if (shouldLogout ?? false) {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.remove('token');
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                ),
              ),
              const SizedBox(height: 30),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, {required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 6),
          Text(text, style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }

  Widget _buildMenuTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isLogout
              ? colorScheme.error.withOpacity(0.1)
              : colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: isLogout ? colorScheme.error : colorScheme.primary, size: 20),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: isLogout ? colorScheme.error : null,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isLogout
                  ? colorScheme.error.withOpacity(0.7)
                  : colorScheme.onSurface.withOpacity(0.6),
            ),
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: isLogout
          ? colorScheme.error.withOpacity(0.6)
          : colorScheme.onSurface.withOpacity(0.4)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Future<bool?> _showLogoutConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text("Cancel")),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
