import 'package:first_app/configs/Exception_config.dart';
import 'package:first_app/controllers/Auth_controller.dart';
import 'package:first_app/providers/auth_provider.dart';
import 'package:first_app/providers/provider.dart';
import 'package:first_app/widgets/button_widget.dart';
import 'package:first_app/widgets/form_widget.dart';
import 'package:first_app/widgets/tools_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPage();
}

class _ChangePasswordPage extends ConsumerState<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final controllers = AuthFormControllers();

  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final token = await ref.read(authStorageProvider).getRefreshToken();
    if (!mounted) return;
    if(token == null)  await ref.read(authProvider.notifier).logout();
    controllers.refreshToken.text = token!;
  }

  @override
  void dispose() {
    controllers.dispose();
    super.dispose();
  }

  Future<void> register() async {

    if (!_formKey.currentState!.validate()) return; 
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try{
      final repo = ref.read(authRepositoryProvider);
      await repo.changePasswordAsync(controllers.toChangePasswordRequest());
      if(!mounted) return;
      await ToolsWidget.showInfoDialog(context, "Modification réussie, ",);
      if(!mounted) return;
      context.pop();

    }catch (e) {
      if (!mounted) return;
      setState(() {errorMessage = ExceptionConfig.extractMessage(e);});
  
    }finally{
      if (mounted) setState(() => isLoading = false);
    }
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modification du mot de passe"),
      ),
      body: Scrollbar(
      controller: _scrollController,
      //thumbVisibility: true,
      //trackVisibility: true,
      child: SingleChildScrollView(

    controller: _scrollController,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 450,
          ),
            //Formulaire
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Icon
                  const Icon( Icons.lock_reset, size: 80, ),
                  const SizedBox(height: 20),

                  const Text( "Modification",
                    style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold, ),
                  ),
                  const SizedBox(height: 10),

                  //AFFICHAGE ERREUR
                  FormWidget.error(errorMessage),
                  const SizedBox(height: 10),

                  //Password
                  FormWidget.passwordField(label: "Mot de passe actuel", controller: controllers.password, icon: Icons.lock, onChanged: (_) => setState(() => errorMessage = null)),
                  const SizedBox(height: 10),

                  //NewPassword
                  FormWidget.passwordField(label: "Nouveau mot de passe", controller: controllers.newPassword, icon: Icons.lock, onChanged: (_) => setState(() => errorMessage = null)),
                  const SizedBox(height: 10),
                  FormWidget.passwordField(
                    label: "Confirmer le nouveau mot de passe", 
                    controller: controllers.confirmPassword, 
                    confirmPsw: controllers.newPassword.text, 
                    icon: Icons.lock, 
                    onChanged: (_) => setState(() => errorMessage = null)
                  ),
                  const SizedBox(height: 10),

                  ButtonWidget.button( text: "Modifier le mot de passe", isLoading: isLoading, onPressed: register, icon: Icons.lock_reset),
                  

                  
                  
                ],
              ),
            ),
          ),
        ),
      ),
      )));
  }
}


/*
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Register Page"),

            ElevatedButton(
              onPressed: () {
                // après register réussi
                Navigator.pop(context); // retour login
              },
              child: const Text("Créer le compte"),
            ),
          ],
        ),
      ),
    );
  }
}*/