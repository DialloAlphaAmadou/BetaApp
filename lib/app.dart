import 'package:first_app/navigations/app_router.dart';
import 'package:first_app/navigations/nav_responsive.dart';
import 'package:first_app/providers/auth_provider.dart';
import 'package:first_app/providers/locale_provider.dart';
import 'package:first_app/providers/theme_provider.dart';
import 'package:first_app/screens/auths/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeProvider);
    //final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      // THEME
      theme: ThemeConfig.lightTheme,
      darkTheme: ThemeConfig.darkTheme,
      themeMode: themeMode,

      /*// LANGUE
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ],*/

      // ROUTER
      routerConfig: router,

    );

  }
}


/*
return ListenableBuilder(

      //Ecouteur globale
      listenable: Listenable.merge([
        ThemeConfig.themeNotifier,
        LocaleConfig.localeNotifier,
        //AuthService.isLoggedIn
      ]), 

      //UI
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          //Thème clair et sombre
          theme: ThemeConfig.lightTheme,
          darkTheme: ThemeConfig.darkTheme,
          themeMode: ThemeConfig.themeNotifier.value,

          //Langue
          locale: LocaleConfig.localeNotifier.value,
          supportedLocales: const [
            Locale('en'),
            Locale('fr'),
          ],

          //Displayer
          home: const SplashScreen()
        );
      }
    ); 
    */
/*
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState  = ref.watch(authProvider);

    //print(authState.info!.email);

    switch (authState.status) {
      case AuthStatus.loading:
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );

      case AuthStatus.authenticated:
        return const NavResponsive();

      case AuthStatus.unauthenticated:
        return const LoginPage();
    }
    
  }
}*/


/*
     // quand l'état change, on redirige
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.status == AuthStatus.loading) return;

      if (next.status == AuthStatus.authenticated) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );

    return auth.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const LoginPage(),
      data: (isLoggedIn) {
        return isLoggedIn ? const NavResponsive() : const LoginPage();
      },
    );
    
    return Scaffold(
      body: Center(
        child: isLoggedIn
            ? const NavResponsive()
            : const LoginPage(),
      ),
    );*/


/*

    //Ecouteur: changer quand le theme change
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, _) {

        //Ecouteur: changer quand le la langue change
        return ValueListenableBuilder<Locale>(
          valueListenable: localeNotifier,
          builder: (context, currentLocale, _){
            
            //Ecouteur: de connexion
            return ValueListenableBuilder<bool>(
              valueListenable: isLoggedIn,
              builder: (context, logged, _){
                
                //Entree principal de l'app
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'First App',

                  // Thème clair et sombre
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.green, 
                      brightness: Brightness.light
                    ),
                    useMaterial3: true,
                  ),
                  darkTheme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.green,
                      brightness: Brightness.dark,
                    ),
                    useMaterial3: true,
                  ),
                  themeMode: currentTheme,

                  // Langue
                  locale: currentLocale,
                  supportedLocales: const [
                    Locale('en'),
                    Locale('fr'),
                  ],

                  // Navigation existante
                  home: logged ? const NavResponsive() : const LoginPage(),
                );
              }
            );
          }
        );
      },
    );
    */



    
  /*  
    
    MaterialApp(
      
      themeMode: ThemeMode.system,
      
      home: const NavResponsive(),
    );.
    */


/*
class _MyAppState extends State<MyApp>{

  bool isMobile(BuildContext context){
    return MediaQuery.of(context).size.width < 600;
  }

  bool isDesktop(BuildContext context){
    return MediaQuery.of(context).size.width >= 1024;
  }

  bool isTablet(BuildContext context){
    return MediaQuery.of(context).size.width >= 600
        && MediaQuery.of(context).size.width < 1024;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(pageTitles[currentIndex]),
        ),
        body: Row(
          children: [
            if(isDesktop(context))
              NavigationRail(
                selectedIndex: currentIndex,
                onDestinationSelected: (index) => setState(() => currentIndex = index),
                labelType: NavigationRailLabelType.all,
                destinations: [
                  NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
                  NavigationRailDestination(icon: Icon(Icons.build), label: Text('Service')),
                  NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Setting')),
                ],
              ),
            Expanded(child: pages[currentIndex]),
          ],
        ),
        bottomNavigationBar: isMobile(context)
            ? BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) => setState(() => currentIndex = index),
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Service'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
              ],
            )
            : null,
        drawer: isTablet(context)
            ? Drawer(
              child: ListView(
                children: [
                  const DrawerHeader(child: Text('Menu', style: TextStyle(fontSize: 24))),
                  ListTile(
                    title: const Text('Home'),
                    onTap: () {
                      setState(() => currentIndex = 0);
                      Navigator.pop(context); // ferme le drawer
                    },
                  ),
                  ListTile(
                    title: const Text('Service'),
                    onTap: () {
                      setState(() => currentIndex = 1);
                      Navigator.pop(context); // ferme le drawer
                    },
                  ),
                  ListTile(
                    title: const Text('Setting'),
                    onTap: () {
                      setState(() => currentIndex = 2);
                      Navigator.pop(context); // ferme le drawer
                    },
                  )
                ],
              ),
            )
          : null,
      )
    );
  }
}
*/