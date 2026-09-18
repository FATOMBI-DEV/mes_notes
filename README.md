# mes_notes

# Mes Notes — Application Mobile Flutter

> Application mobile de prise de notes personnelle développée avec **Flutter** et **SQLite**, dans le cadre du projet DCLIC – Niveau Intermédiaire (OIF).

---

## Présentation

**Mes Notes** est une application mobile de prise de notes personnelle. Elle permet à un utilisateur authentifié de **créer**, **consulter**, **modifier** et **supprimer** ses notes, stockées localement dans une base de données **SQLite**.

L'application est conçue pour être :
- **Sécurisée** : accès conditionné par une authentification
- **Ergonomique** : interface épurée respectant le Material Design
- **Persistante** : les données restent disponibles hors ligne
- **Éco-conçue** : code léger, pas de surcharge réseau

---

## Fonctionnalités

### Authentification
- Écran de connexion avec nom d'utilisateur et mot de passe
- Vérification sécurisée (mot de passe hashé en SHA-256)
- Message d'erreur clair en cas d'échec
- Bouton de déconnexion dans l'AppBar

### Gestion des notes
- **Ajout** d'une note (titre + contenu)
- **Consultation** de la liste des notes
- **Modification** via une boîte de dialogue (dialog)
- **Suppression** avec confirmation (dialog)
- **Enregistrement** transparent dans SQLite

### Écran Splash
- Écran d'accueil animé avec icône personnalisée
- Redirection automatique vers l'écran de connexion après 3 secondes

---

## Architecture du projet
lib/
├── main.dart # Point d'entrée de l'application
├── models/
│ └── note.dart # Modèle de données Note
├── database/
│ └── database_helper.dart # Gestion SQLite (CRUD + init)
├── screens/
│ ├── splash_screen.dart # Écran de démarrage
│ ├── login_screen.dart # Écran de connexion
│ ├── home_screen.dart # Liste des notes
│ └── add_note_screen.dart # Écran d'ajout
└── widgets/
├── edit_note_dialog.dart # Dialog de modification
└── delete_confirm_dialog.dart # Dialog de confirmation


---

## Technologies utilisées

| Technologie           | Version | Rôle                              |
|-----------------------|---------|-----------------------------------|
|     Flutter           | 3.x     | Framework de développement mobile |
|     Dart              | 3.x     | Langage de programmation          |
|     Sqflite           | ^2.3.0  | Plugin SQLite pour Flutter        |
|     Crypto            | ^3.0.3  | Hashage SHA-256 des mots de passe |
|     Material Design   | -       | Charte graphique                  |
|---------------------------------------------------------------------|
---

## Identifient par défaut pour se connecter à l’application 
    o Nom d’utilisateur : Marius 
    o Mot de passe : Marius#2026 