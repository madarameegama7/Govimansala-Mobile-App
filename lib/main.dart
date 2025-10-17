import 'package:agriplant/pages/onboarding_page.dart';
import 'package:agriplant/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:agriplant/pages/login_page.dart';
import 'package:agriplant/pages/info_center/agri_articles.dart';
import 'package:agriplant/pages/info_center/crop_cultivation.dart';
import 'package:agriplant/pages/info_center/government_policies.dart';
import 'package:agriplant/pages/info_center/bank_loans.dart';
import 'package:agriplant/pages/info_center/agri_essentials.dart';

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
      },
    );
  }
}

// @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Govimansala',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//         textTheme: GoogleFonts.poppinsTextTheme(),
//       ),
//       home: LoginScreen(),
//     );
//   }
// }
