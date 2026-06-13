import 'package:first_app/configs/Exception_config.dart';
import 'package:first_app/providers/auth_provider.dart';
import 'package:first_app/providers/user_provider.dart';
import 'package:first_app/screens/auths/login_page.dart';
import 'package:first_app/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final authState = ref.watch(authProvider);
    final profile = ref.watch(profileProvider);

    if (authState.status == AuthStatus.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (authState.status == AuthStatus.unauthenticated || authState.info == null ) {
      return const LoginPage();
    }

    final info = authState.info!;

     return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenue ${info.userName}"),
        
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(profileProvider);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Bienvenue ${info.userName}"),
            const SizedBox(height: 10),
            Text("ID: ${info.userId}"),
            const SizedBox(height: 10),
            Text("Email: ${info.email}"),
            const SizedBox(height: 10),
            Text("Roles: ${info.roles}"),
            const SizedBox(height: 10),
            Text("***********************************************"),
            profile.when(
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => FormWidget.textError(ExceptionConfig.extractMessage(e)),
              data: (user) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("FirstName: ${user.firstName}"),
                  Text("LastName: ${user.lastName}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}