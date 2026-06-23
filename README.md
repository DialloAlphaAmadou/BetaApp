# BetaApp

Application mobile et desktop développée avec Flutter.

## Description

BetaApp est une application multiplateforme développée avec Flutter permettant aux utilisateurs d'accéder aux services de l'application à travers une interface moderne et intuitive.

L'application communique avec une API REST sécurisée pour l'authentification, la gestion des données et les opérations métier.

## Fonctionnalités

- Authentification utilisateur
- Gestion des sessions
- Consommation d'API REST
- Gestion des tokens JWT
- Rafraîchissement automatique des Access Tokens
- Interface responsive
- Compatible Android, iOS, Windows, macOS et Linux

## Technologies

### Frontend

- Flutter
- Dart

### Backend

- API REST

## Architecture

```text
Flutter App
     │
     │ HTTPS
     ▼
REST API
     │
     ▼
Database
```

## Gestion de l'authentification

- Connexion avec email et mot de passe
- Access Token JWT
- Refresh Token sécurisé
- Renouvellement automatique du token expiré
- Déconnexion automatique si le Refresh Token est invalide

## Installation

### Prérequis

- Flutter SDK
- Android Studio ou VS Code

### Cloner le projet

```bash
git clone https://github.com/DialloAlphaAmadou/BetaApp.git
cd BetaApp
```

### Installer les dépendances

```bash
flutter pub get
```

### Lancer l'application

```bash
flutter run
```

## Configuration

Créer un fichier de configuration :

```env
API_URL=http://localhost:5000/api
```

## Plateformes supportées

- Android
- iOS
- Windows
- macOS
- Linux

## Auteur

Alpha Amadou Diallo

Application Flutter consommant une API REST sécurisée.
