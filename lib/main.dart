import 'package:govimansala/pages/onboarding_page.dart';
import 'package:govimansala/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:govimansala/pages/login_page.dart';
import 'package:govimansala/pages/info_center/agri_articles.dart';
import 'package:govimansala/pages/info_center/crop_cultivation.dart';
import 'package:govimansala/pages/info_center/government_policies.dart';
import 'package:govimansala/pages/info_center/bank_loans.dart';
import 'package:govimansala/pages/info_center/agri_essentials.dart';
import 'package:govimansala/pages/order.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Govimansala',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/onboarding': (_) => const OnboardingPage(),
        '/login': (_) => LoginScreen(),
        '/': (_) =>
            const HomePage(), // HomePage holds AppBar and BottomNavigationBar
        '/crop-cultivation': (_) => const CropCultivationPage(),
        '/agri-essentials': (_) => const AgriEssentialsPage(),
        '/agri-articles': (_) => const AgriArticlesPage(),
        '/bank-loans': (_) => const BankLoansPage(),
        '/government-policies': (_) => const GovernmentPoliciesPage(),
        '/orderDetails': (context) => OrderDetailsPage(),
      },
    );
  }
}
