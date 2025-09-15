#!/usr/bin/env bash

# Script unifié pour enregistrer l'écran en MP4 ou GIF
# Usage: screen_record.sh [mp4|gif] [output_directory]
# Default: mp4, $HOME/Videos/Screen Records

# Arguments
FORMAT="${1:-mp4}"
OUTPUT_DIR="${2:-$HOME/Videos/Screen Records}"

# Validation du format
if [[ "$FORMAT" != "mp4" && "$FORMAT" != "gif" ]]; then
    notify-send "Erreur" "Format non supporté: $FORMAT. Utilisez 'mp4' ou 'gif'"
    exit 1
fi

# Fichiers PID pour distinguer les deux types d'enregistrement
PIDFILE="/tmp/wf-recorder-$FORMAT.pid"
TEMP_DIR="/tmp"
WAYBAR_STATUS_FILE="/tmp/screen_recording_status"

# Créer le répertoire de sortie s'il n'existe pas
mkdir -p "$OUTPUT_DIR"

# Fonctions pour gérer le statut waybar
update_waybar_status() {
    local recording_type="$1"
    echo "{\"text\": \"🔴\", \"tooltip\": \"Recording $recording_type\", \"class\": \"recording\"}" > "$WAYBAR_STATUS_FILE"
    pkill -SIGUSR2 waybar 2>/dev/null || true
}

clear_waybar_status() {
    rm -f "$WAYBAR_STATUS_FILE"
    pkill -SIGUSR2 waybar 2>/dev/null || true
}

# Fonction pour détecter le moniteur actif
get_active_monitor() {
    # Obtenir le moniteur où se trouve actuellement la souris
    hyprctl monitors -j | jq -r '.[] | select(.focused) | .name'
}

# Fonction pour arrêter l'enregistrement MP4
stop_recording_mp4() {
    if [ -f "$PIDFILE" ]; then
        PID=$(cat "$PIDFILE")
        if kill -0 "$PID" 2>/dev/null; then
            kill -INT "$PID"
            rm -f "$PIDFILE"
            clear_waybar_status
            notify-send "Enregistrement d'écran" "Enregistrement MP4 arrêté et sauvegardé"
        else
            rm -f "$PIDFILE"
            clear_waybar_status
        fi
    else
        notify-send "Erreur" "Aucun enregistrement MP4 en cours"
    fi
}

# Fonction pour arrêter l'enregistrement et créer le GIF
stop_recording_gif() {
    if [ -f "$PIDFILE" ]; then
        PID=$(cat "$PIDFILE")
        if kill -0 "$PID" 2>/dev/null; then
            kill -INT "$PID"
            wait "$PID" 2>/dev/null
            rm -f "$PIDFILE"
            
            # Attendre un peu que le fichier soit complètement écrit
            sleep 1
            
            # Convertir en GIF et copier dans le presse-papier
            TEMP_MP4="$TEMP_DIR/screen-record-temp.mp4"
            TEMP_GIF="$TEMP_DIR/screen-record-temp.gif"
            
            if [ -f "$TEMP_MP4" ]; then
                notify-send "Enregistrement d'écran" "Conversion en GIF en cours..."
                
                # Convertir en GIF avec une palette optimisée
                ffmpeg -i "$TEMP_MP4" -vf "fps=15,scale=1024:-1:flags=lanczos,palettegen" -y "$TEMP_DIR/palette.png" 2>/dev/null
                ffmpeg -i "$TEMP_MP4" -i "$TEMP_DIR/palette.png" -filter_complex "fps=15,scale=1024:-1:flags=lanczos[x];[x][1:v]paletteuse" -y "$TEMP_GIF" 2>/dev/null
                
                if [ -f "$TEMP_GIF" ]; then
                    # Copier le GIF dans le presse-papier
                    wl-copy < "$TEMP_GIF"
                    
                    # Sauvegarder le GIF dans le répertoire de sortie
                    GIF_FILENAME="screen-record-$(date +%Y%m%d_%H%M%S).gif"
                    cp "$TEMP_GIF" "$OUTPUT_DIR/$GIF_FILENAME"
                    
                    clear_waybar_status
                    notify-send "Enregistrement d'écran" "GIF créé et copié dans le presse-papier!\nSauvegardé: $OUTPUT_DIR/$GIF_FILENAME"
                    
                    # Nettoyer les fichiers temporaires
                    rm -f "$TEMP_MP4" "$TEMP_GIF" "$TEMP_DIR/palette.png"
                else
                    clear_waybar_status
                    notify-send "Erreur" "Échec de la conversion en GIF"
                    rm -f "$TEMP_MP4"
                fi
            else
                clear_waybar_status
                notify-send "Erreur" "Fichier d'enregistrement introuvable"
            fi
        else
            rm -f "$PIDFILE"
            clear_waybar_status
        fi
    else
        notify-send "Erreur" "Aucun enregistrement GIF en cours"
    fi
}

# Fonction pour démarrer l'enregistrement MP4
start_recording_mp4() {
    if [ -f "$PIDFILE" ]; then
        notify-send "Erreur" "Un enregistrement MP4 est déjà en cours"
        exit 1
    fi
    
    # Nom du fichier avec timestamp
    FILENAME="screen-record-$(date +%Y%m%d_%H%M%S).mp4"
    FILEPATH="$OUTPUT_DIR/$FILENAME"
    
    # Détecter le moniteur actif
    ACTIVE_MONITOR=$(get_active_monitor)
    
    # Démarrer l'enregistrement avec sélection de zone sur le bon moniteur
    wf-recorder -o "$ACTIVE_MONITOR" -g "$(slurp)" -f "$FILEPATH" &
    
    # Sauvegarder le PID
    echo $! > "$PIDFILE"
    
    # Mettre à jour le statut waybar
    update_waybar_status "MP4"
    
    notify-send "Enregistrement d'écran" "Enregistrement MP4 démarré\nFichier: $FILEPATH"
}

# Fonction pour démarrer l'enregistrement GIF
start_recording_gif() {
    if [ -f "$PIDFILE" ]; then
        notify-send "Erreur" "Un enregistrement GIF est déjà en cours"
        exit 1
    fi
    
    # Fichier temporaire
    TEMP_MP4="$TEMP_DIR/screen-record-temp.mp4"
    
    # Nettoyer les anciens fichiers temporaires
    rm -f "$TEMP_MP4" "$TEMP_DIR/screen-record-temp.gif" "$TEMP_DIR/palette.png"
    
    # Détecter le moniteur actif
    ACTIVE_MONITOR=$(get_active_monitor)
    
    # Démarrer l'enregistrement avec sélection de zone sur le bon moniteur
    wf-recorder -o "$ACTIVE_MONITOR" -g "$(slurp)" -f "$TEMP_MP4" &
    
    # Sauvegarder le PID
    echo $! > "$PIDFILE"
    
    # Mettre à jour le statut waybar
    update_waybar_status "GIF"
    
    notify-send "Enregistrement d'écran" "Enregistrement GIF démarré\nRépertoire de sortie: $OUTPUT_DIR\nAppuyez à nouveau pour arrêter et convertir"
}

# Logique principale selon le format
if [[ "$FORMAT" == "mp4" ]]; then
    # Vérifier si un enregistrement MP4 est en cours
    if [ -f "$PIDFILE" ]; then
        stop_recording_mp4
    else
        start_recording_mp4
    fi
elif [[ "$FORMAT" == "gif" ]]; then
    # Vérifier si un enregistrement GIF est en cours
    if [ -f "$PIDFILE" ]; then
        stop_recording_gif
    else
        start_recording_gif
    fi
fi
