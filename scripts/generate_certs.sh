#!/bin/bash

# Définition du chemin des certificats
CERT_DIR="./nginx/ssl"
CERT_KEY="${CERT_DIR}/key.pem"
CERT_FILE="${CERT_DIR}/cert.pem"

echo "Création du répertoire des certificats : ${CERT_DIR}"
mkdir -p "$CERT_DIR"

if [ -f "$CERT_KEY" ] || [ -f "$CERT_FILE" ]; then
    echo "Les certificats existent déjà. Suppression..."
    rm "$CERT_KEY" "$CERT_FILE"
fi

echo "Génération d'un certificat SSL auto-signé de 365 jours..."

# Utilisation d'openssl pour créer une clé privée et le certificat
# -x509: Certificat auto-signé
# -nodes: Pas de chiffrement de clé (pour le démarrage automatique)
# -days 365: Validité du certificat
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$CERT_KEY" \
    -out "$CERT_FILE" \
    -subj "/C=CH/ST=VD/L=Yverdon/O=Projet IaC/OU=IT/CN=localhost"

echo "Génération des certificats terminée. Ils se trouvent dans ${CERT_DIR}"
echo "N'oubliez pas d'exécuter: chmod +x scripts/generate_certs.sh"