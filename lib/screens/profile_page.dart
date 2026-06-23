import 'package:first_app/configs/Exception_config.dart';
import 'package:first_app/navigations/app_router.dart';
import 'package:first_app/providers/auth_provider.dart';
import 'package:first_app/serivices/user_service.dart';
import 'package:first_app/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final profileAsync = ref.watch(profileProvider);

    if (authState.status == AuthStatus.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (authState.status == AuthStatus.unauthenticated || authState.info == null) {
      ref.watch(routerProvider);
    }

    final auth = authState.info!;

    return Scaffold(
      appBar: AppBar(
        title: Text(auth.userName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        /*actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(profileProvider),
          ),
          const SizedBox(width: 8,)
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async { await ref.read(authProvider.notifier).logout();}
          ),
        ],*/
      ),

      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => SelectionArea(child: FormWidget.textError(ExceptionConfig.extractMessage(e))),
        data: (profile) {
          return SelectionArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  _Header(profile: profile),

                  const SizedBox(height: 20),
                  

                  _Section(
                    titleWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [ 
                        const Text( "IDENTITÉ",
                          style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, ),
                        ),

                        Row(
                          children: [
                            FormWidget.checkboxTileR(title: "Visible", value: profile.isPublicIdentity, onChanged: (value) {}),
                            IconButton( icon: const Icon(Icons.edit), onPressed: () {}, ),
                          ],
                        ),
                      ],
                    ),
                    children: [
                      _Tile("Prénom", profile.firstName),
                      _Tile("Nom", profile.lastName),
                      _Tile("Genre", profile.gender ?? "-"),
                      _Tile("Date de naissance", profile.birthDate?.toString().split(" ").first ?? "-"),
                    ],
                  ),

                  _Section(
                    titleWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [ 
                        const Text( "CONTACT",
                          style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, ),
                        ),

                        Row(
                          children: [
                            FormWidget.checkboxTileR(title: "Visible", value: profile.isPublicContact, onChanged: (value) {}),
                            IconButton( icon: const Icon(Icons.edit), onPressed: () {}, ),
                          ],
                        ),
                      ],
                    ),
                    children: [
                      _Tile("Adresse", profile.address ?? "-"),
                      _Tile("Ville", profile.city ?? "-"),
                      _Tile("État", profile.state ?? "-"),
                      _Tile("Pays", profile.country ?? "-"),
                      _Tile("Code postal", profile.postalCode ?? "-"),
                      _Tile("Email", profile.email),
                      _Tile("Numero de telephone", profile.phoneNumber ?? "-"),
                    ],
                  ),

                  _Section(
                    title: "AFFICHAGE",
                    children: [
                      _Tile("Display Name", profile.displayName ?? "-"),
                      _Tile("Bio", profile.bio ?? "-"),
                      _Tile("Langue", profile.language ?? "-"),
                    ],
                  ),

                  

                  //Info non modifiable
                  _Section(
                    title: "INFORMATION",
                    children: [
                      _Tile("User ID", profile.id),
                      _Tile("Non d'utilisateur", profile.userName),
                      _Tile("Créé le", profile.createdAt?.toString().split(" ").first ?? "-"),
                       _Tile("Mis à jour", profile.updatedAt.toString()),
                    ],
                  ),

                  _Section(
                    title: "PARAMÈTRES",
                    children: [
                      //FormWidget.checkboxTile(title: "Profil public", value: profile.isPublic, onChanged: (v) {}),
                      FormWidget.switchTile(title: "Profil public", value: profile.isPublic, onChanged: (v) {}),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          //style: ElevatedButton.styleFrom( backgroundColor: Colors.red, foregroundColor: Colors.white, ),
                          icon: Icon(Icons.edit),
                          label: Text("Modifier le mot de passe"),
                          onPressed: () => context.push(AppRoutes.changePassword),
                          //onPressed: ()  => NavHelper.navPage(context, ChangePasswordPage())
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom( backgroundColor: Colors.red, foregroundColor: Colors.white, ),
                          icon: Icon(Icons.logout),
                          label: Text("Déconnexion"),
                          onPressed: () async { await ref.read(authProvider.notifier).logout();}
                        ),
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class _Header extends StatelessWidget {
  final dynamic profile;

  const _Header({ required this.profile,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 45,
            child: Icon(Icons.person, size: 40),
          ),
          const SizedBox(height: 10),

          Text(
            profile.displayName ?? "${profile.firstName} ${profile.lastName}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          Text(
            profile.userName,
            style: const TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 10),

          if (profile.bio != null)
            Text(
              profile.bio!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
        ],
      ),
    );
  }
}


class _Section extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget> children;

  const _Section({
    this.title,
    this.titleWidget,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            if (titleWidget != null)
              titleWidget!
            else if (title != null)
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const SizedBox(height: 8),
            const Divider(),

            // CONTENT
            ...children,
          ],
        ),
      ),
    );
  }
}


class _Tile extends StatelessWidget {
  final String label;
  final String value;

  const _Tile(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}





