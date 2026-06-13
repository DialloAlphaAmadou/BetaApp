import 'package:dio/dio.dart';
import 'package:first_app/app.dart';
import 'package:first_app/configs/Exception_config.dart';
import 'package:first_app/controllers/Auth_controller.dart';
import 'package:first_app/providers/provider.dart';
import 'package:first_app/widgets/Button_widget.dart';
import 'package:first_app/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final controllers = AuthFormControllers();

  bool isLoading = false;
  String? errorMessage;

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
      await repo.registerAsync(controllers.toRegisterRequest());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Inscription réussie"),
          duration: Duration(seconds: 5),
        ),
      );

      await Future.delayed(const Duration(seconds: 2));

      if(!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SplashScreen()));

    } on DioException catch (e) {

      if (!mounted) return;
      setState(() {errorMessage = ExceptionConfig.extractMessage(e);});
  
    }finally{
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
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
                  const Icon( Icons.person_add_alt_1, size: 80, ),
                  const SizedBox(height: 20),

                  const Text( "Enregistrement",
                    style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold, ),
                  ),
                  const SizedBox(height: 10),

                  //AFFICHAGE ERREUR
                  FormWidget.error(errorMessage),
                  const SizedBox(height: 10),

                  FormWidget.textField(label: "NOM", controller: controllers.lastName, icon: Icons.person_outline, onChanged: (_) => setState(() => errorMessage = null)),
                  const SizedBox(height: 10),
                  //Username
                  FormWidget.textField(label: "PRENOM", controller: controllers.firstName, icon: Icons.badge, onChanged: (_) => setState(() => errorMessage = null)),
                  const SizedBox(height: 10),
                  //Username
                  FormWidget.emailField(label: "EMAIL", controller: controllers.email, icon: Icons.email_outlined, onChanged: (_) => setState(() => errorMessage = null)),
                  const SizedBox(height: 10),
                  //Username
                  FormWidget.phoneField(label: "PHONE", controller: controllers.phoneNumber, requiredField: false, icon: Icons.phone_outlined, onChanged: (_) => setState(() => errorMessage = null)),
                  const SizedBox(height: 10),

                  //Username
                  FormWidget.textField(label: "Nom d'utilisateur", controller: controllers.userName, icon: Icons.alternate_email, onChanged: (_) => setState(() => errorMessage = null)),
                  const SizedBox(height: 10),

                  //Password
                  FormWidget.passwordField(label: "Mot de passe", controller: controllers.password, icon: Icons.lock, onChanged: (_) => setState(() => errorMessage = null)),
                  const SizedBox(height: 10),

                  ButtonWidget.button( text: "Se connecter", isLoading: isLoading, onPressed: register, icon: Icons.app_registration),
                  

                  
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
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