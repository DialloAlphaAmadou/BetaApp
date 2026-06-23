import 'package:first_app/main.dart';
import 'package:first_app/navigations/nav_responsive.dart';
import 'package:first_app/providers/auth_provider.dart';
import 'package:first_app/screens/auths/change_passeword.dart';
import 'package:first_app/screens/auths/config.dart';
import 'package:first_app/screens/auths/confirm_account.dart';
import 'package:first_app/screens/auths/login_page.dart';
import 'package:first_app/screens/auths/register_page.dart';
import 'package:first_app/screens/auths/reset_password.dart';
import 'package:first_app/screens/auths/send_confirmation.dart';
import 'package:first_app/screens/home_page.dart';
import 'package:first_app/screens/profile_page.dart';
import 'package:first_app/screens/service_page.dart';
import 'package:first_app/screens/setting_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const main = '/';
  static const home = '/home';
  static const services = '/services';
  static const settings = '/settings';

  static const login = '/login';
  static const register = '/register';
  static const send = '/send-confirmation';
  static const confirmAccount = '/account-confirmation';
  static const resetPassword = '/reset-password';

  static const profile = '/profile';
  static const changePassword = '/change-password';
}

extension GoRouterStateX on GoRouterState {
  T? extraAs<T>() {
    final extra = this.extra;
    return extra is T ? extra : null;
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,

    redirect: (context, state) {

      final publicRoutes = {
        AppRoutes.login,
        AppRoutes.register,
        AppRoutes.send,
        AppRoutes.confirmAccount,
        AppRoutes.resetPassword,
      };

      final isAuth = auth.status == AuthStatus.authenticated;
      final isLoginRoute = publicRoutes.contains(state.matchedLocation);

      if (!isAuth && !isLoginRoute) {
        return AppRoutes.login;
      }

      if (isAuth && isLoginRoute) {
        return AppRoutes.home;
      }

      return null;
    },

    routes: [

      

      GoRoute(path: AppRoutes.login, builder: (context, state) => const LoginPage(),),
      GoRoute(path: AppRoutes.register, builder: (context, state) => const RegisterPage(),),
      
      GoRoute(path: AppRoutes.resetPassword, builder: (context, state){
          final email = state.extraAs<String>()!;
          //if (email == null) return LoginPage();
          return ResetPasswordPage(email: email);
        },
      ),

      GoRoute(path: AppRoutes.send, builder: (context, state) 
        {
          final type = state.extraAs<SendType>()!;
          //if (type == null) return NavResponsive();
          return SendPage(type: type);
        },
      ),

      GoRoute(path: AppRoutes.confirmAccount, builder: (context, state) 
        {
          final email = state.extraAs<String>()!;
          //if (email == null) return LoginPage();
          return ConfirmAccountPage(email: email);
        },
      ),

      ShellRoute(
        builder: (context, state, child) {
          return NavResponsive(child: child);
        },
        routes: [
          GoRoute(path: AppRoutes.home, builder: (context, state) => const HomePage()),
          GoRoute(path: AppRoutes.services, builder: (context, state) => const ServicePage()),
          GoRoute(path: AppRoutes.settings, builder: (context, state) => const SettingPage()),
        ],
      ),
      

      GoRoute(path: AppRoutes.profile, builder: (context, state) => const ProfilePage(),),
      GoRoute(path: AppRoutes.changePassword, builder: (context, state) => const ChangePasswordPage(),),

      

    ],

    
  );
});


/*

ShellRoute(
        builder: (context, state, child) {
          return NavResponsive(child: child);
        },
        routes: [
          GoRoute(name: "Home", path: AppRoutes.home, builder: (context, state) => const ProfilePage()),
          GoRoute(name: "Service", path: AppRoutes.services, builder: (context, state) => const ServicePage()),
          GoRoute(name: "Setting", path: AppRoutes.settings, builder: (context, state) => const SettingPage()),
        ],
      ),

GoRoute(path: AppRoutes.home, builder: (context, state) => const NavResponsive(child: HomePage()),),
      GoRoute(path: AppRoutes.services, builder: (context, state) => const NavResponsive(child: ServicePage()),),
      GoRoute(path: AppRoutes.settings, builder: (context, state) => const NavResponsive(child: SettingPage()),),


GoRoute(path: AppRoutes.main, builder: (context, state) => const NavResponsive(),
        routes: [
          GoRoute(path: AppRoutes.home, builder: (context, state) => const HomePage(),),
          GoRoute(path: AppRoutes.services, builder: (context, state) => const ServicePage(),),
          GoRoute(path: AppRoutes.settings, builder: (context, state) => const SettingPage(),),
        ],
      ),
      */


