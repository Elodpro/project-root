#!/bin/bash

# --- ÉTAPE 1: VÉRIFICATION ---
echo "Vérification des prérequis (Docker et Docker Compose)..."
if ! command -v docker &> /dev/null || ! command -v docker-compose &> /dev/null
then
    echo "ERREUR: Docker ou Docker Compose n'est pas installé. Veuillez les installer."
    exit 1
fi

echo "Rendre les scripts Bash exécutables..."
chmod +x scripts/backup.sh
chmod +x scripts/generate_certs.sh
chmod +x scripts/init-db.sh

./scripts/generate_certs.sh

# --- ÉTAPE 2: CONSTRUCTION DES IMAGES ---
echo "Construction des images personnalisées..."
# Construit l'image Wordpress en utilisant le Dockerfile dans docker/wordpress/
docker-compose build wordpress || { echo "Échec de la construction de l'image Wordpress"; exit 1; }
# NOTE: MySQL et Nginx utilisent des images officielles (pas besoin de les construire si aucun Dockerfile n'est spécifié)

# --- ÉTAPE 3: DÉPLOIEMENT/ORCHESTRATION ---
echo "Déploiement des conteneurs avec Docker Compose..."
# -d pour détacher et exécuter en arrière-plan
# --remove-orphans pour nettoyer les anciens conteneurs non référencés
docker-compose up -d --remove-orphans || { echo "Échec du démarrage de l'infrastructure"; exit 1; }

# --- ÉTAPE 4: VÉRIFICATION POST-DÉPLOIEMENT ---
echo "Vérification du statut des conteneurs..."
docker-compose ps

echo "Déploiement terminé. L'application devrait être accessible via Nginx."

echo "Déploiement de l'environnement de production..."

# Utilise le fichier de configuration de production
docker-compose -f docker-compose.prod.yml up -d || { echo "Échec du déploiement de production"; exit 1; }

echo "Vérification du statut des conteneurs de production..."
docker-compose -f docker-compose.prod.yml ps