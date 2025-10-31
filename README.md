# Projet 2 : Déploiement Automatisé d'une Application Web avec Base de DonnéesCe projet vise à créer un environnement de développement et de production automatisé pour une application web simple (Wordpress) en utilisant Docker et des techniques d'Infrastructure as Code (IaC)3. L'infrastructure est composée de trois services principaux : Wordpress, MySQL et Nginx

# 1. Prérequis
# Docker et Docker Compose (version 3.8 ou supérieure).
# Un shell Bash pour exécuter les scripts.

# 2. Structure du Projet
# Une arborescence détaillée est disponible dans la documentation technique (docs/).

# 3. Configuration initiale et SécuritéRemplir le fichier .env : 1. Définir les mots de passe forts et les identifiants de la base  de données (MYSQL_ROOT_PASSWORD, MYSQL_DATABASE, etc.).
# 2. Génération des certificats (HTTPS) : Les certificats SSL/TLS pour Nginx sont requis pour le déploiement sécurisé. Ils sont générés via scripts/generate_certs.sh.

# 4. Monitoring
# L'environnement de production inclut un monitoring de base avec Prometheus (port 9090) et Grafana (port 3000).

# 5. Sauvegarde
# Pour sauvegarder la base de données, exécutez le script : ./scripts/backup.sh .