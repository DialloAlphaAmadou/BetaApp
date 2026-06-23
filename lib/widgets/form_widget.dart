import 'package:flutter/material.dart';

class FormWidget {

  static Widget textError(String? message) {
    if (message == null || message.isEmpty) {
      return const SizedBox.shrink();
    }
    return Text(
      message, 
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.w500,
      ),);
  }

   //Message d'erreur global
  static Widget error(String? message) {
    return _base(message, Colors.red);
  }

  //Message succès
  static Widget success(String? message) {
    return _base(message, Colors.green);
  }

  //Message info
  static Widget info(String? message) {
    return _base(message, Colors.blue);
  }

  static Widget _base(String? message, Color color) {
    if (message == null || message.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // USERNAME FIELD
  static Widget textField({required TextEditingController controller, required String label,
    bool requiredField = true, String? errorText,
    void Function(String)? onChanged, IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: icon != null ? Icon(icon) : null,
        errorText: errorText,
      ),
      validator: (value) {
        final v = value?.trim() ?? '';
        //pas obligatoire → on accepte vide
        if (!requiredField && v.isEmpty) {
          return null;
        }
        //obligatoire
        if (requiredField && v.isEmpty) {
          return "Ce champ est obligatoire";
        }
        return null;
      },
    );
  }

  // EMAIL FIELD
  static Widget emailField({required TextEditingController controller, required String label,
    bool requiredField = true, String? errorText,
    void Function(String)? onChanged, IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: icon != null ? Icon(icon) : null,
        errorText: errorText,
      ),
      validator: (value) {
        final v = value?.trim() ?? '';
        //pas obligatoire → on accepte vide
        if (!requiredField && v.isEmpty) {
          return null;
        }
        //obligatoire
        if (requiredField && v.isEmpty) {
          return "Ce champ est obligatoire";
        }
        if (!v.contains('@')) {
          return "Email invalide";
        }
        return null;
      },
    );
  }

  //PASSWORD FIELD
  static Widget passwordField({ required TextEditingController controller, required String label,
    bool requiredField = true, String? errorText,
    void Function(String)? onChanged, IconData? icon, String? confirmPsw
  }) {
    
    final obscureNotifier = ValueNotifier<bool>(true);
    return ValueListenableBuilder(
      valueListenable: obscureNotifier,
      builder: (context, obscure, _){

        return TextFormField(
          controller: controller,
          obscureText: obscure,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            prefixIcon: icon != null ? Icon(icon) : null,
            errorText: errorText,
            suffixIcon: IconButton(
              icon: Icon( obscure ? Icons.visibility_off : Icons.visibility ),
              onPressed: () => obscureNotifier.value = !obscureNotifier.value,
            ),
          ),
          validator: (value) {
            final v = value?.trim() ?? '';
            //pas obligatoire → on accepte vide
            if (!requiredField && v.isEmpty) return null;
            //obligatoire
            if (requiredField && v.isEmpty) return "Ce champ est obligatoire";
            if (v.length < 6 && confirmPsw == null) return "Minimum 6 caractères";
            if(v != confirmPsw && confirmPsw != null)  return 'Les mots de passe ne correspondent pas';
            return null;
          },
        );
      },
    );
  }

  //NUMBER FIELD
  static Widget numberField({required TextEditingController controller, required String label,
    bool requiredField = true, String? errorText,
    void Function(String)? onChanged, IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: icon != null ? Icon(icon) : null,
        errorText: errorText,
      ),
      validator: (value) {
        final v = value?.trim() ?? '';
        //pas obligatoire → on accepte vide
        if (!requiredField && v.isEmpty) {
          return null;
        }
        //obligatoire
        if (requiredField && v.isEmpty) {
          return "Ce champ est obligatoire";
        }
        return null;
      },
    );
  }

  //NUMBER FIELD
  static Widget phoneField({required TextEditingController controller, required String label,
    bool requiredField = true, String? errorText,
    void Function(String)? onChanged, IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: icon != null ? Icon(icon) : null,
        errorText: errorText,
      ),
      validator: (value) {
        final v = value?.trim() ?? '';
        //pas obligatoire → on accepte vide
        if (!requiredField && v.isEmpty) return null;
        
        //obligatoire
        if (requiredField && v.isEmpty) return "Ce champ est obligatoire";
        
        final regex = RegExp(r'^[0-9+\s()-]{7,15}$');
        if (!regex.hasMatch(v)) return "Numéro de téléphone invalide";
        
        return null;
      },
    );
  }



  //Checkbox
  static Widget checkboxTile({ required bool value, required ValueChanged<bool?> onChanged, required String title, }) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      onChanged: onChanged,
      //controlAffinity: ListTileControlAffinity.leading,
    );
  }

  static Widget checkboxTileR({ required bool value, required ValueChanged<bool?> onChanged, required String title, }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        Checkbox( value: value, onChanged: onChanged, ),
      ],
    );
  }

  static Widget checkboxTileL({ required bool value, required ValueChanged<bool?> onChanged, required String title, }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox( value: value, onChanged: onChanged, ),
        Text(title),
      ],
    );
  }

  static Widget switchTile({ required String title, required bool value, required ValueChanged<bool> onChanged}){
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value, 
      onChanged: onChanged,
    );
  }

  static Widget switchTileL({ required String title, required bool value, required ValueChanged<bool> onChanged}){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        const SizedBox(width: 5),
        Transform.scale( scale: 0.7, // 80% de la taille normale
          child: Switch( value: value, onChanged: onChanged, ),
        ),
      ],
    );
  }

  static Widget switchTileR({ required String title, required bool value, required ValueChanged<bool> onChanged}){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale( scale: 0.7, // 80% de la taille normale
          child: Switch( value: value, onChanged: onChanged, ),
        ),
        const SizedBox(width: 5),
        Text(title),
      ],
    );
  }






}