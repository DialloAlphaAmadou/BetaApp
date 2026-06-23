import 'package:first_app/configs/Exception_config.dart';
import 'package:first_app/controllers/Auth_controller.dart';
import 'package:first_app/navigations/app_router.dart';
import 'package:first_app/navigations/nav_controller.dart';
import 'package:first_app/providers/auth_provider.dart';
import 'package:first_app/providers/theme_provider.dart';
import 'package:first_app/screens/auths/config.dart';
import 'package:first_app/screens/auths/register_page.dart';
import 'package:first_app/screens/auths/send_confirmation.dart';
import 'package:first_app/widgets/button_widget.dart';
import 'package:first_app/widgets/form_widget.dart';
import 'package:first_app/widgets/tools_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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
      final notifier = ref.read(authProvider.notifier);
      await notifier.login(controllers.toLoginRequest(rememberMe));

    }catch (e) {
      if (!mounted) return;
      final message = ExceptionConfig.extractMessage(e);
      if(message == "901") {
        var label = "Veuillez confirmer votre email";
        setState(() {errorMessage = label;});
        final result = await ToolsWidget.showConfirmDialog(context, label,);

        if (!mounted) return;
        errorMessage = null;
        controllers.clear();
        if (result == true) context.push(AppRoutes.send, extra: SendType.confirmAccount);
        
        //await NavHelper.navPage(context, SendPage(type: SendType.confirmAccount));
      }else{
        setState(() {errorMessage = ExceptionConfig.extractMessage(e);});
      }

    }finally{
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon( ref.watch(themeProvider) == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode, ),
            onPressed: () {ref.read(themeProvider.notifier).toggleTheme();} 
          ),
          const SizedBox(width: 8,),
        ],
        
      ),
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
                  const Icon( Icons.lock_outline, size: 80, ),
                  const SizedBox(height: 20),

                  const Text( "Connexion",
                    style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold, ),
                  ),
                  const SizedBox(height: 10),

                  //AFFICHAGE ERREUR
                  FormWidget.error(errorMessage),
                  const SizedBox(height: 10),

                  //Username
                  FormWidget.textField(label: "Nom d'utilisateur", controller: controllers.userName, icon: Icons.person, onChanged: (_) => setState(() => errorMessage = null)),
                  const SizedBox(height: 10),

                  //Password
                  FormWidget.passwordField(label: "Mot de passe", controller: controllers.password, icon: Icons.key, onChanged: (_) => setState(() => errorMessage = null)),
                  const SizedBox(height: 10),

                  //RemenberMe
                  FormWidget.checkboxTile(title: "Se souvenir de moi", value: rememberMe, onChanged: (value) => setState(() => rememberMe = value ?? false)),
                  const SizedBox(height: 10),

                  //Button Submit
                  ButtonWidget.button( text: "Se connecter", isLoading: isLoading, onPressed: login, icon: Icons.login),
                  const SizedBox(height: 10),

                  //Navigation Pages
                  TextButton(
                    onPressed: (){
                      controllers.clear();
                      context.push(AppRoutes.register);
                      //NavHelper.navPage(context, const RegisterPage());
                    }, 
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person_add),
                        const SizedBox(width: 6),
                        Text("Créer un compte"),
                      ],
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      controllers.clear();
                      context.push(AppRoutes.send, extra: SendType.resetPassword);
                      //NavHelper.navPage(context, const SendPage(type: SendType.resetPassword));
                    }, 
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lock_reset),
                        const SizedBox(width: 6,),
                        Text("Mot de passe oublié ?")
                      ],
                    )
                  )
                  
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
TextFormField(
                    controller: username,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: "Non d'utilisateur",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Veuillez entrer votre nom d'utilisateur";
                      }
                      /*if (!value.contains('@')) {
                        return "Email invalide";
                      }*/

                      return null;
                    },
                  ),


TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Mot de passe",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.key),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer votre mot de passe";
                      }

                      if (value.length < 6) {
                        return "Minimum 6 caractères";
                      }

                      return null;
                    },
                  ),
                  
                  
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Se souvenir de moi"),
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  */