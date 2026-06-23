import 'package:first_app/configs/Exception_config.dart';
import 'package:first_app/controllers/Auth_controller.dart';
import 'package:first_app/navigations/app_router.dart';
import 'package:first_app/providers/auth_provider.dart';
import 'package:first_app/widgets/button_widget.dart';
import 'package:first_app/widgets/form_widget.dart';
import 'package:first_app/widgets/tools_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ConfirmAccountPage extends ConsumerStatefulWidget {
  final String email;
  const ConfirmAccountPage({super.key, required this.email});

  @override
  ConsumerState<ConfirmAccountPage> createState() => _ConfirmAccountPage();
}

class _ConfirmAccountPage extends ConsumerState<ConfirmAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final controllers = AuthFormControllers();

  bool rememberMe = false;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    controllers.email.text = widget.email;
  }

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
      await repo.confirmAccountAsync(controllers.toConfirmAccountRequest());

      if(!mounted) return;
      await ToolsWidget.showInfoDialog(context, "Felicitation votre compte a ete confirmer",);

      if(!mounted) return;
      controllers.clear();
      print("***************");
      context.go(AppRoutes.login);
      //await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => SplashScreen()), (route) => false);

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
      appBar: AppBar(title: Text("Confirmation du compte")),
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

                  FormWidget.textField(label: "Code", controller: controllers.code, icon: Icons.code, onChanged: (_) => setState(() => errorMessage = null)),
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