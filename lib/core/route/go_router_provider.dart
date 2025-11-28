import 'package:mendlify/features/RepairGuide/ui/screens/find_guide_screen.dart';
import 'package:mendlify/features/home/diagnostics/ui/screens/diagnosis_one_screen.dart';
import 'package:mendlify/features/home/diagnostics/ui/screens/diagnosis_two_screen.dart';
import 'package:mendlify/features/home/presentation/ui/screens/main_home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mendlify/features/home/profile/ui/screens/diagnosis_history_screen.dart';
import '../../features/RepairGuide/ui/screens/add_guide_screen.dart';
import '../../features/RepairGuide/ui/screens/guide_detail_screen.dart';
import '../../features/authentication/forgotpassword/presentation/ui/screens/code_verification_screen.dart';
import '../../features/authentication/forgotpassword/presentation/ui/screens/forgot_password_enter_email_screen.dart';
import '../../features/authentication/forgotpassword/presentation/ui/screens/forgot_password_enter_new_password_screen.dart';
import '../../features/authentication/signin/presentation/ui/screens/login_screen.dart';
import '../../features/authentication/signup/presentation/ui/screens/signup_screen.dart';
import '../../features/home/presentation/ui/screens/all_posts.dart';
import '../../features/home/presentation/ui/screens/new_post_screen.dart';
import '../../features/home/presentation/ui/screens/post_detail_screen.dart';
import '../../features/home/presentation/ui/screens/vendor_screen.dart';
import '../../features/home/profile/ui/screens/edit_bike_info_screen.dart';
import '../../features/home/profile/ui/screens/edit_personal_info_screen.dart';
import '../../features/home/profile/ui/screens/my_guides_screen.dart';
import '../../features/home/profile/ui/screens/my_posts_screen.dart';
import '../../features/home/profile/ui/screens/profile_screen.dart';
import '../../features/startup/presentation/ui/screens/choice_screen.dart';
import '../../features/startup/presentation/ui/screens/landing_screen.dart';
import '../../features/startup/presentation/ui/screens/splash_screen.dart';
import 'route_names.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  // final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: getRoutePath(landingRoute),
    routes: [
      GoRoute(
        path: getRoutePath(splashRoute),
        name: splashRoute,
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: getRoutePath(landingRoute),
        name: landingRoute,
        builder: (context, state) => const LandingScreen(),
      ),
      GoRoute(
        path: getRoutePath(choiceRoute),
        name: choiceRoute,
        builder: (context, state) => const ChoiceScreen(),
      ),

      GoRoute(
        path: getRoutePath(loginRoute),
        name: loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),


      GoRoute(
        path: getRoutePath(forgotPasswordEnterEmailRoute),
        name: forgotPasswordEnterEmailRoute,
        builder: (context, state) => const ForgotPasswordEnterEmailScreen(),
      ),
      GoRoute(
        path: getRoutePath(codeVerificationRoute),
        name: codeVerificationRoute,
        builder: (context, state) => const CodeVerificationScreen(),
      ),
      GoRoute(
        path: getRoutePath(forgotPasswordEnterNewPasswordRoute),
        name: forgotPasswordEnterNewPasswordRoute,
        builder: (context, state) => const ForgotPasswordEnterNewPasswordScreen(),
      ),


      GoRoute(
        path: getRoutePath(singUpRoute),
        name: singUpRoute,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: getRoutePath(homeRoute),
        name: homeRoute,
        builder: (context, state) => const MainHomeScreen(),
      ),
      GoRoute(
        path: getRoutePath(findGuideRoute),
        name: findGuideRoute,
        builder: (context, state) => const FindGuideScreen(),
      ),
      GoRoute(
        path: getRoutePath(guideDetailRoute),
        name: guideDetailRoute,
        builder: (context, state) => const GuideDetailScreen(),
      ),
      GoRoute(
        path: getRoutePath(addGuideRoute),
        name: addGuideRoute,
        builder: (context, state) => const AddGuideScreen(),
      ),
      GoRoute(
        path: getRoutePath(diagnosisOneRoute),
        name: diagnosisOneRoute,
        builder: (context, state) => const DiagnosisOneScreen(),
      ),
      GoRoute(
        path: getRoutePath(diagnosisTwoRoute),
        name: diagnosisTwoRoute,
        builder: (context, state) => const DiagnosisTwoScreen(),
      ),
      GoRoute(
        path: getRoutePath(vendorRoute),
        name: vendorRoute,
        builder: (context, state) => const VendorScreen(),
      ),
      GoRoute(
        path: getRoutePath(communityRoute),
        name: communityRoute,
        builder: (context, state) => const AllPostsScreen(),
      ),
      GoRoute(
        path: getRoutePath(newPostRoute),
        name: newPostRoute,
        builder: (context, state) => const NewPostScreen(),
      ),
      GoRoute(
        path: getRoutePath(postDetailRoute),
        name: postDetailRoute,
        builder: (context, state) => const PostDetailScreen(),
      ),
      GoRoute(
        path: getRoutePath(profileRoute),
        name: profileRoute,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: getRoutePath(editBikeInfoRoute),
        name: editBikeInfoRoute,
        builder: (context, state) => const EditBikeInfoScreen(),
      ),
      GoRoute(
        path: getRoutePath(editPersonalInfoRoute),
        name: editPersonalInfoRoute,
        builder: (context, state) => const EditPersonalInfoScreen(),
      ),
      GoRoute(
        path: getRoutePath(myGuidesRoute),
        name: myGuidesRoute,
        builder: (context, state) => const MyGuidesScreen(),
      ),
      GoRoute(
        path: getRoutePath(diagnosisHistoryRoute),
        name: diagnosisHistoryRoute,
        builder: (context, state) => const DiagnosisHistoryScreen(),
      ),
      GoRoute(
        path: getRoutePath(myPostsRoute),
        name: myPostsRoute,
        builder: (context, state) => const MyPostsScreen(),
      ),
    ],
  );
});

String getRoutePath(String route) {
  return "/$route";
}