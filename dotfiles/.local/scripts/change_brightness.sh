#!/bin/sh

MIN=1

# Récupère la valeur max
max=$(brightnessctl m)

# Vérifie que l'utilisateur passe "set" suivi d'une valeur en pourcentage (5%-, +5%, etc.)
if echo "$1" | grep -Eq '^([0-9]+%[-+]?)|([+-][0-9]+%)$'; then
    current=$(brightnessctl g)
    current_percent=$((100 * current / max))
    if [ "$current_percent" == "$MIN" ]; then
        brightnessctl set "0%" > /dev/null
    fi
    
    # Applique la luminosité demandée
    brightnessctl set "$1" > /dev/null

    # Calcule la nouvelle valeur
    new=$(brightnessctl g)
    new_percent=$((100 * new / max))

    # Si inférieur au minimum, on force
    if [ "$new_percent" -lt "$MIN" ]; then
        brightnessctl set "${MIN}%"
    fi
else
    echo "Usage: $0 +N% (or N%-)"
    exit 1
fi
