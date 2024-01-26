#!/bin/bash

set -euo pipefail

echo '=> Votre trigramme en minuscule ? (Première lettre prénom, Permière lettre nom, dernière lettre nom)'
read tgm
echo => Votre trigramme $tgm

echo '=> Votre nom de contexte quatreapp ? taper entrée pour utiliser "quatreapp" ou faire un k ctx pour le trouver'
read context
if [ -z "$context"  ]; then
  context="quatreapp"
fi
echo => Votre contexte $context

echo "=> Chargement du context quatreapp"
kubectl ctx $context
echo "=> Chargement du namespace"
kubectl ns 4sh-formation-$tgm

echo "=> Consruire une image"
docker build - --platform linux/amd64 -t europe-docker.pkg.dev/quatreapp/k8straining/$tgm-shell << EOF
FROM bash
ENTRYPOINT ["bash", "-l", "-c", "echo SUCCESS && sleep infinity"]
EOF

echo "=> Pousser une image"
docker push europe-docker.pkg.dev/quatreapp/k8straining/$tgm-shell

echo "=> Supression du pod si déjà présent"
kubectl delete pod $tgm-shell || echo continue

echo "=> Lancement d'un pod"
kubectl run --image europe-docker.pkg.dev/quatreapp/k8straining/$tgm-shell $tgm-shell -- bash

echo "=> Attente du statut READY"
kubectl wait --for=condition=ready pod $tgm-shell

echo "=> Supression et attente"
kubectl delete pod $tgm-shell

echo "VALIDATION OK !!!"

