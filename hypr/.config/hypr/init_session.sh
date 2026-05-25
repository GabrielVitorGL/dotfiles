#!/bin/bash

# 1. Ajusta os monitores (o script do buraco negro que fizemos)
~/.config/hypr/adjust_screen_gpu_passthrough.sh &

# 2. Restaura a sessão se houver uma "foto" salva
if [ -f /tmp/restore_session.sh ]; then
    bash /tmp/restore_session.sh &
fi

# 3. Inicia o que você sempre usa (Waybar, etc)
# Coloque aqui os outros comandos que você tinha no exec-once
# Exemplo: waybar & hyprpaper &
