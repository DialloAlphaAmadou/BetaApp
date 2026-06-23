import 'package:first_app/configs/Exception_config.dart';
import 'package:first_app/controllers/Auth_controller.dart';
import 'package:first_app/navigations/app_router.dart';
import 'package:first_app/providers/auth_provider.dart';
import 'package:first_app/screens/auths/config.dart';
import 'package:first_app/widgets/button_widget.dart';
import 'package:first_app/widgets/form_widget.dart';
import 'package:first_app/widgets/tools_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SendPage extends ConsumerStatefulWidget {
  final SendType type;
  const SendPage({super.key, required this.type});

  @override
  ConsumerState<SendPage> createState() => _SendPage();
}

class _SendPage extends ConsumerState<SendPage> {
  final _formKey = GlobalKey<FormState>();
  final controllers = AuthFormControllers();

  bool rememberMe = false;
  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    controllers.dispose();
    super.dispose();
  }

  Future<void> login() async {

    if (!_formKey.currentState!.validate()) return; 
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try{
      final repo = ref.read(authRepositoryProvider);
      await repo.sendConfirmEmailAsync(controllers.toEmailRequest());
      
      if(!mounted) return;
      await ToolsWidget.showInfoDialog(context, "Un code de confirmation a ete envoyer a votre email",);

      if(!mounted) return;

      switch (widget.type) {
        case SendType.confirmAccount:
          context.push(AppRoutes.confirmAccount, extra: controllers.email.text);
          //await NavHelper.navPage(context, ConfirmAccountPage(email: controllers.email.text));
          break;

        case SendType.resetPassword:
          context.push(AppRoutes.resetPassword, extra: controllers.email.text);
          //await NavHelper.navPage(context, ResetPasswordPage(email: controllers.email.text));
          break;
      }

    }catch (e) {
      if (!mounted) return;
      setState(() {errorMessage = ExceptionConfig.extractMessage(e);});

    }finally{
      if (mounted) setState(() => isLoading = false);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.type.title)),
      
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints( maxWidth: 450, ),
            //Formulaire
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Icon
                  const Icon( Icons.lock_reset, size: 80, ),
                  const SizedBox(height: 20),

                  const Text( "Verification",
                    style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold, ),
                  ),
                  const SizedBox(height: 10),

                  //AFFICHAGE ERREUR
                  FormWidget.error(errorMessage),
                  const SizedBox(height: 10),

                  FormWidget.emailField(label: "EMAIL", controller: controllers.email, icon: Icons.email_outlined, onChanged: (_) => setState(() => errorMessage = null)),
                  const SizedBox(height: 10),
                  //Button Submit
                  ButtonWidget.button( text: "Verifier", isLoading: isLoading, onPressed: login, icon: Icons.lock_reset),
                  const SizedBox(height: 10),

                  //ButtonWidget.textButton( context: context, text: "Mot de passe oublié ?", page: const ResetPasswordPage(), icon: Icons.lock_reset ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}