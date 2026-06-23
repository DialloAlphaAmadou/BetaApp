import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ExceptionConfig  {
  
  
  static String extractMessage(dynamic e) {

    if (e is DioException) {
      //Réponse serveur (API error 400/500)

      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        
        //message simple
        if (data['message'] != null) {
          return data['message'];
        }

        //ASP.NET validation errors
        if (data['errors'] != null && data['errors'] is Map) {
          return (data['errors'] as Map)
              .values
              .expand((e) => e)
              .join('\n');
        }

        //fallback optionnel
        if (data['title'] != null) {
          return data['title'];
        }
      }

      //Erreurs réseau Dio
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          return "Connexion expirée";

        case DioExceptionType.sendTimeout:
          return "Délai d'envoi dépassé";

        case DioExceptionType.receiveTimeout:
          return "Délai de réponse dépassé";

        case DioExceptionType.connectionError:
          return "Erreur de connexion internet";

        case DioExceptionType.cancel:
          return "Requête annulée";

        case DioExceptionType.badCertificate:
          return "Certificat invalide";

        case DioExceptionType.badResponse:
          return "Erreur serveur (${e.response?.statusCode ?? 'inconnue'})";

        default:
          return "Erreur réseau inconnue";
      }
    }

    // 2. Erreurs Dart classiques
    if (e is FormatException) {
      return "Format de données invalide";
    }

    if (e is SocketException) {
      return "Pas de connexion internet";
    }

    // 3. fallback
    return e?.toString() ?? "Erreur inconnue";
  }

  
    
  
}



/*
    return FutureBuilder<bool>(
      future: AuthStorage().isAuthAsync(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center( child: CircularProgressIndicator()),
          );
        }
        return snapshot.data! ? const NavResponsive() : const LoginPage();
      },
    );*/