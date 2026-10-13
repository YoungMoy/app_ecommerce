🛒 App E-commerce Flutter avec Riverpod
📋 Présentation du projet

Cette application est un mini système e-commerce développé avec Flutter et Riverpod dans le cadre d'un projet de validation des compétences en gestion d'état (State Management).

L'objectif principal est de démontrer la maîtrise de :

Flutter
Riverpod
Architecture en couches
Gestion d'état réactive
Persistance locale
Gestion des données asynchrones avec AsyncValue
Navigation entre écrans
Tests unitaires

L'application permet à un utilisateur de :

Consulter un catalogue de produits
Visualiser les détails d'un produit
Ajouter des produits au panier
Gérer les quantités du panier
Ajouter ou supprimer des favoris
Conserver les favoris même après fermeture de l'application
Filtrer les produits
Trier les produits
Consulter un profil utilisateur simulé
🎯 Objectifs pédagogiques

Ce projet répond aux exigences suivantes :

✅ Utilisation exclusive de Riverpod

✅ Utilisation de plusieurs providers

✅ Utilisation de FutureProvider

✅ Utilisation de StateProvider

✅ Utilisation de NotifierProvider

✅ Utilisation de AsyncNotifierProvider

✅ Gestion des états de chargement

✅ Gestion des erreurs

✅ Séparation de la logique métier et des widgets

✅ Architecture en couches

✅ Persistance locale avec SharedPreferences

✅ Tests unitaires

🏗️ Architecture du projet

Le projet suit une architecture en couches inspirée des architectures professionnelles Flutter.

app_ecommerce/
│
├── pubspec.yaml
├── README.md
│
├── assets/
│   │
│   ├── products.json
│   │
│   └── images/
│       ├── hp_laptop.jpg
│       ├── rosalba.jpg
│       ├── sharphy.jpg
│       └── avatar_placeholder.jpg
│
├── test/
│   │
│   ├── application/
│   │   ├── cart_notifier_test.dart
│   │   └── favorites_notifier_test.dart
│   │
│   ├── infrastructure/
│   │   └── mock_product_repository_test.dart
│   │
│   └── widget_test.dart
│
└── lib/
    │
    ├── main.dart
    │
    ├── application/
    │   │
    │   ├── notifiers/
    │   │   ├── cart_notifier.dart
    │   │   └── favorites_notifier.dart
    │   │
    │   └── providers/
    │       ├── cart_provider.dart
    │       ├── favorites_provider.dart
    │       ├── products_provider.dart
    │       ├── filter_provider.dart
    │       ├── sort_provider.dart
    │       ├── filtered_products_provider.dart
    │       └── user_provider.dart
    │
    ├── domain/
    │   │
    │   ├── models/
    │   │   ├── product.dart
    │   │   ├── cart_item.dart
    │   │   └── user.dart
    │   │
    │   └── repositories/
    │       └── product_repository.dart
    │
    ├── infrastructure/
    │   ├── local_favorites_storage.dart
    │   └── mock_product_repository.dart
    │
    ├── presentation/
    │   │
    │   ├── app.dart
    │   │
    │   ├── pages/
    │   │   ├── product_list_page.dart
    │   │   ├── product_detail_page.dart
    │   │   ├── favorites_page.dart
    │   │   ├── cart_page.dart
    │   │   └── profile_page.dart
    │   │
    │   └── widgets/
    │       ├── product_tile.dart
    │       └── quantity_selector.dart
    │
    └── utils/



📐 Justification de l'architecture

L'application suit une architecture en couches afin de séparer les responsabilités :

Presentation

Responsable de :

l'affichage des données ;
la navigation ;
les interactions utilisateur.
Application

Responsable de :

la gestion d'état ;
les providers Riverpod ;
les notifiers ;
la logique d'application.
Domain

Responsable de :

la modélisation métier ;
les contrats de repository ;
les entités manipulées par l'application.
Infrastructure

Responsable de :

la lecture des données JSON ;
le stockage local avec SharedPreferences ;
les implémentations concrètes des repositories.

Cette séparation améliore :

la maintenabilité ;
l'évolutivité ;
la testabilité ;
la réutilisabilité du code.

📂 Description des couches
1. Presentation Layer
presentation/


Contient uniquement l'interface utilisateur.

Pages
product_list_page.dart
product_detail_page.dart
favorites_page.dart
cart_page.dart
profile_page.dart

Widgets
product_tile.dart
quantity_selector.dart


Responsabilités :

Afficher les données
Réagir aux actions utilisateur
Consommer les Providers
2. Application Layer
application/


Contient toute la logique Riverpod.

Notifiers
cart_notifier.dart
favorites_notifier.dart


Responsabilités :

Modifier l'état
Appliquer les règles métier
Communiquer avec les providers
Providers
products_provider.dart
cart_provider.dart
favorites_provider.dart
filter_provider.dart
sort_provider.dart
filtered_products_provider.dart
user_provider.dart


Responsabilités :

Exposer les données à l'application
Donner accès aux Notifiers
Calculer les états dérivés
3. Domain Layer
domain/


Contient les objets métier.

Models
Product
CartItem
User

Repositories
ProductRepository


Responsabilités :

Définir les contrats métier
Ne dépendre d'aucune implémentation technique
4. Infrastructure Layer
infrastructure/


Contient les implémentations concrètes.

Fichiers
mock_product_repository.dart
local_favorites_storage.dart


Responsabilités :

Lecture du JSON
SharedPreferences
Gestion des données locales
🧩 Modèles
Product

Représente un produit du catalogue.

Attributs :

String id
String name
double price
String description
String imageUrl
String category

CartItem

Représente un article du panier.

Attributs :

Product product
int quantity

User

Représente le profil utilisateur.

Attributs :

String id
String name
String email
String phone
String address
String avatarUrl

⚙️ Riverpod

L'application utilise exclusivement Riverpod.

Provider

Utilisé pour fournir des dépendances.

Exemple :

productRepositoryProvider
mockUserProvider

FutureProvider

Permet de gérer les données asynchrones.

Exemple :

productsProvider
productByIdProvider

StateProvider

Permet de gérer les états simples.

Exemple :

filterProvider
sortProvider

NotifierProvider

Permet de gérer le panier.

Exemple :

cartProvider

AsyncNotifierProvider

Permet de gérer les favoris persistés.

Exemple :

favoritesProvider

📦 Liste complète des Providers
productRepositoryProvider

Expose le repository des produits.

Type :

Provider<ProductRepository>

productsProvider

Charge l'ensemble des produits.

Type :

FutureProvider<List<Product>>

productByIdProvider

Retourne un produit à partir de son identifiant.

Type :

FutureProvider.family<Product, String>

cartProvider

Expose le panier.

Type :

NotifierProvider<CartNotifier, List<CartItem>>

favoritesProvider

Expose les favoris persistants.

Type :

AsyncNotifierProvider<FavoritesNotifier, List<String>>

filterProvider

Stocke le filtre courant.

Type :

StateProvider<ProductFilter>

sortProvider

Stocke le critère de tri.

Type :

StateProvider<ProductSort>

filteredProductsProvider

Retourne une liste filtrée et triée.

Type :

Provider<List<Product>>

mockUserProvider

Expose le profil utilisateur simulé.

Type :

Provider<User>

🛍️ Fonctionnalités
Catalogue des produits

Affichage de :

Nom
Prix
Catégorie
Image

Le catalogue est chargé depuis :

assets/products.json

Détails produit

Affichage :

Image
Nom
Prix
Description complète
Gestion de quantité

Actions :

Ajouter aux favoris
Ajouter au panier
Panier

Fonctionnalités :

Ajout de produit
Suppression de produit
Modification de quantité
Calcul du total
Validation de commande
Vidage du panier
Favoris

Fonctionnalités :

Ajouter un produit aux favoris
Retirer un produit des favoris
Afficher la liste des favoris
Persistance locale
Filtrage

Possibilités :

ProductFilterType.all
ProductFilterType.category
ProductFilterType.search

Tri

Possibilités :

priceAsc
priceDesc
nameAsc
nameDesc

Profil Utilisateur

Profil simulé affichant :

Nom
Email
Téléphone
Adresse
Avatar
💾 Persistance locale

Les favoris sont conservés avec :

SharedPreferences


Fichier concerné :

local_favorites_storage.dart


Les données sont sauvegardées automatiquement après chaque modification.

📄 Source des données

Les données sont simulées via :

assets/products.json


Extrait :

[
  {
    "id": "p1",
    "name": "HP EliteBook 840"
  }
]

🔄 Gestion des états asynchrones

L'application utilise :

AsyncValue


afin de gérer :

Loading
Error
Data

Exemple :

productsAsync.when(
  data: ...
  loading: ...
  error: ...
)

✅ Tests

Tests réalisés :

CartNotifier

Vérification :

ajout produit
suppression produit
mise à jour quantité
nettoyage panier
Product Model

Vérification :

Product.fromJson()

Application

Vérification :

démarrage de l'application
chargement des widgets de base
📚 Packages utilisés
flutter_riverpod

Gestion d'état.

flutter_riverpod: ^2.6.1

shared_preferences

Persistance locale.

shared_preferences: ^2.5.6

🚀 Installation
Cloner le projet
git clone https://github.com/votre-compte/app_ecommerce.git

Accéder au projet
cd app_ecommerce

Installer les dépendances
flutter pub get

Vérifier le code
flutter analyze

Lancer les tests
flutter test

Exécuter l'application
Chrome
flutter run -d chrome

Edge
flutter run -d edge

Windows
flutter run -d windows

🖼️ Assets
assets/
│
├── products.json
│
└── images/
    ├── hp_laptop.png
    ├── rosalba.png
    ├── sharphy.png
    └── avatar_placeholder.png

📈 Compétences démontrées
Flutter UI
Navigation
State Management Riverpod
FutureProvider
StateProvider
NotifierProvider
AsyncNotifierProvider
SharedPreferences
Architecture en couches
Gestion des états asynchrones
Tests unitaires
Organisation professionnelle du code
👨‍💻 Auteur

Projet réalisé dans le cadre d'un exercice de validation des compétences Flutter et Riverpod.

Technologies principales :

Flutter
Dart
Riverpod
SharedPreferences
✅ Résultat attendu

L'utilisateur doit pouvoir :

Consulter les produits.
Afficher un produit.
Ajouter au panier.
Modifier les quantités.
Ajouter aux favoris.
Retrouver ses favoris après redémarrage.
Filtrer les produits.
Trier les produits.
Consulter son profil.
Utiliser une application Flutter structurée selon une architecture professionnelle.
