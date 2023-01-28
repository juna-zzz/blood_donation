import 'package:blood_bank/presentation/awards/award.dart';
import 'package:blood_bank/presentation/donation/donation.dart';
import 'package:blood_bank/presentation/map/center_donation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../about_us/about_us_screen.dart';
import '../forgot_password/forgotpassword.dart';
import '../home_screen/home_screen.dart';
import '../intro_screen/intro_screen.dart';
import '../profile/components/profile_ui.dart';
import '../profile/profile_screen.dart';
import '../sign_in/components/sign_in_screen.dart';
import '../sign_up/sign_up_screen.dart';
import '../widgets/splash_screen.dart';
import 'strings_manager.dart';

class Routes {
  static const String splash = "/splash";
  static const String initialScreenRoute = "/";
  static const String signInRoute = "/signIn";
  static const String signUpRoute = "/signUp";
  static const String homeScreenRoute = "/homeScreen";
  static const String profileRoute = "/profile";
  static const String profileView = "/profileView";
  static const String donationAdd = "/product";
  static const String forgot = "/forgot";
  static const String awards = "/awards";
  static const String aboutus = "/aboutus";
  static const String donationCenter = "/donation";
}

class Routegenerator {
  static Route<dynamic> getRoute(
    RouteSettings routeSettings,
  ) {
    switch (routeSettings.name) {
      case Routes.initialScreenRoute:
        return PageTransition(
          child: const IntroScreen(),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 400),
        );
      // return MaterialPageRoute(builder: (_) => const IntroScreen());
      case Routes.signInRoute:
        return PageTransition(
          child: const SignInScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 400),
        );
      // return MaterialPageRoute(builder: (_) => const SignInScreen());
      case Routes.signUpRoute:
        return PageTransition(
          child: const SignUpScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 400),
        );
      // return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case Routes.homeScreenRoute:
        return PageTransition(
          child: const HomeScreen(),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 400),
        );
      // return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.profileRoute:
        return PageTransition(
          child: const ProfileScreen(),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 400),
        );
      // return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case Routes.profileView:
        return PageTransition(
          child: const ProfilePageDesign(),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 400),
        );

      // return MaterialPageRoute(builder: (_) => const SuccessScreen());

      case Routes.forgot:
        return PageTransition(
          child: const ForgotPassword(),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 400),
        );
      // return MaterialPageRoute(builder: (_) => const ForgotPassword());

      case Routes.aboutus:
        return PageTransition(
          child: const AboutUsPage(),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 400),
        );
      // return MaterialPageRoute(builder: (_) => const History());
      case Routes.donationAdd:
        return PageTransition(
          child: const DonationForm(),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 400),
        );

      case Routes.awards:
        return PageTransition(
          child: const Awards(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 400),
        );

      case Routes.donationCenter:
        return PageTransition(
          child: const DonationCenter(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 400),
        );
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text(AppStrings.noRouteFound),
            ),
            body: const Center(
              child: Text(AppStrings.noRouteFound),
            )));
  }
}
