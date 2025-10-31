#!/bin/bash

# Ce script est exécuté par le Docker entrypoint de MySQL si on le monte dans 
# /docker-entrypoint-initdb.d/

echo "Exécution du script d'initialisation de la base de données..."

# Exemple: Créer un utilisateur spécifique ou une table si non fait par les variables d'environnement.
# Puisque l'image officielle MySQL gère déjà la création de l'utilisateur et de la DB via les variables
# d'environnement (MYSQL_DATABASE, MYSQL_USER), ce script est souvent laissé vide ou utilisé
# pour des configurations très spécifiques non gérées par défaut.

# Ici, nous pouvons vérifier que la base de données existe
echo "Vérification de la base de données: ${MYSQL_DATABASE}"

# Laissez le script vide si la configuration par variables d'environnement est suffisante.
# Si vous aviez besoin d'importer un schéma ou des données initiales:
# mysql -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < /chemin/vers/schema.sql

echo "Initialisation de la base de données terminée."