import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:life_pulse/presentation/auth/forgot_password/forgot_password_view.dart';
import 'package:life_pulse/presentation/auth/forgot_password/new_password_view.dart';
import 'package:life_pulse/presentation/auth/forgot_password/otp_view.dart';
import 'package:life_pulse/presentation/auth/lets_in/letsIn_view.dart';
import 'package:life_pulse/presentation/auth/sign_in/signIn_view.dart';
import 'package:life_pulse/presentation/auth/sign_up/signUp_view.dart';
import 'package:life_pulse/presentation/home_tab/home/home_view.dart';
import 'package:life_pulse/presentation/home_tab/notifications/notifications_view.dart';
import 'package:life_pulse/presentation/home_tab/payment/confirm_payment/confirm_payment_view.dart';
import 'package:life_pulse/presentation/home_tab/payment/credit/add_credit_view.dart';
import 'package:life_pulse/presentation/home_tab/payment/receipt/receipt_view.dart';
import 'package:life_pulse/presentation/home_tab/payment/select_payment/select_payment_view.dart';
import 'package:life_pulse/presentation/layout/layout_view.dart';
import 'package:life_pulse/presentation/onboarding/onboarding_view.dart';
import 'package:life_pulse/presentation/profile_tab/edit_profile/edit_profile_view.dart';
import 'package:life_pulse/presentation/profile_tab/help/help_center_view.dart';
import 'package:life_pulse/presentation/profile_tab/help/support_chat_view.dart';
import 'package:life_pulse/presentation/profile_tab/invite_friend/invite_friend_view.dart';
import 'package:life_pulse/presentation/profile_tab/language/language_settings_view.dart';
import 'package:life_pulse/presentation/profile_tab/notifications/notifications_settings_view.dart';
import 'package:life_pulse/presentation/profile_tab/privacy_policy/privacy_policy_view.dart';
import 'package:life_pulse/presentation/profile_tab/profile/profile_view.dart';
import 'package:life_pulse/presentation/profile_tab/security/security_settings_view.dart';
import 'package:life_pulse/presentation/resources/strings_manager.dart';
import 'package:life_pulse/presentation/transations_tab/transactions_view.dart';

class Routes {
  // static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String letsInRoute = '/letsIns';
  static const String signInRoute = '/signIn';
  static const String signUpRoute = '/signUp';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String newPasswordRoute = '/newPassword';
  static const String otpRoute = '/otpRoute';
  static const String mainRoute = '/main';
  static const String homeRoute = '/home';
  static const String notificationsRoute = '/notifications';
  static const String searchRoute = '/search';
  static const String tutorProfileRoute = '/tutorProfile';
  static const String reviewRoute = '/review';
  static const String allReviewsRoute = '/allReviews';
  static const String allLessonsRoute = '/allLessons';
  static const String selectPaymentRoute = '/selectPayment';
  static const String addCreditRoute = '/addCredit';
  static const String confirmPaymentRoute = '/confirmPayment';
  static const String receiptRoute = '/receipt';
  static const String transactionsRoute = '/transactions';


  static const String profileRoute = '/profile';
  static const String notificationsSettingsRoute = '/notificationsSettings';
  static const String securitySettingsRoute = '/securitySettings';
  static const String languageSettingsRoute = '/languageSettings';
  static const String privacyPolicyRoute = '/privacyPolicy';
  static const String inviteFriendsRoute = '/inviteFriends';
  static const String editProfileRoute = '/editProfile';
  static const String helpCenterRoute = '/helpCenter';

  static const String inboxRoute = '/inbox';

  static const String supportChatView = '/supportChat';

}

class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      // case Routes.splashRoute:
      //   return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.letsInRoute:
        return MaterialPageRoute(builder: (_) => const LetsInView());
      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case Routes.signInRoute:
        return MaterialPageRoute(builder: (_) => const SignInView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.otpRoute:
        return MaterialPageRoute(builder: (_) => const OTPScreen());
        case Routes.newPasswordRoute:
        return MaterialPageRoute(builder: (_) => const NewPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => LayoutView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.notificationsRoute:
        return MaterialPageRoute(builder: (_) => const NotificationsView());
      case Routes.selectPaymentRoute :
        return MaterialPageRoute(builder: (_) => const SelectPaymentView());
      case Routes.addCreditRoute :
        return MaterialPageRoute(builder: (_) => const AddCreditView());
      case Routes.confirmPaymentRoute :
        return MaterialPageRoute(builder: (_) => const ConfirmPaymentView());
      case Routes.receiptRoute :
        return MaterialPageRoute(builder: (_) => const ReceiptView());
      case Routes.transactionsRoute :
        return MaterialPageRoute(builder: (_) => const TransactionsView());
      case Routes.profileRoute :
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case Routes.notificationsSettingsRoute :
        return MaterialPageRoute(builder: (_) => const NotificationsSettingsView());
      case Routes.securitySettingsRoute :
        return MaterialPageRoute(builder: (_) => const SecuritySettingsView());
      case Routes.languageSettingsRoute :
        return MaterialPageRoute(builder: (_) => const LanguageSettingsView());
      case Routes.privacyPolicyRoute :
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyView());
      case Routes.inviteFriendsRoute :
        return MaterialPageRoute(builder: (_) => const InviteFriendsView());
      case Routes.editProfileRoute :
        return MaterialPageRoute(builder: (_) => const EditProfileView());
      case Routes.helpCenterRoute :
        return MaterialPageRoute(builder: (_) => const HelpCenterView());
      case Routes.supportChatView :
        return MaterialPageRoute(builder: (_) => SupportChatView());



      default:
        return unDefinedRoute();
    }
  }
  static Route<dynamic> unDefinedRoute(){
    return MaterialPageRoute(builder: (_) => Scaffold(
      appBar: AppBar(title: const Text(AppStrings.noRoute),),
      body: const Center(child: Text(AppStrings.noRoute),),
    ));
  }
}