#!/bin/bash

# Pega todos os sinks disponíveis
sinks=$(pactl list sinks | grep -E "Description:|Name:" | paste - - | sed 's/.*Description: //' | sed 's/\t.*Name: /\t/')

# Monta lista de nomes amigáveis
names=$(pactl list sinks | grep "Description:" | sed 's/.*Description: //')

# Sink atual
current=$(pactl get-default-sink)
current_desc=$(pactl list sinks | grep -A1 "Name: $current" | grep "Description:" | sed 's/.*Description: //')

# Abre rofi e pega a escolha
chosen=$(echo "$names" | rofi -dmenu \
  -p "Output" \
  -theme ~/.config/rofi/audio.rasi \
  -mesg "Current: $current_desc")

[ -z "$chosen" ] && exit

# Encontra o nome técnico do sink escolhido
new_sink=$(pactl list sinks | grep -B1 "Description: $chosen" | grep "Name:" | sed 's/.*Name: //')

# Define como padrão e move todos os streams ativos
pactl set-default-sink "$new_sink"
pactl list sink-inputs | grep "Sink Input #" | sed 's/Sink Input #//' | while read -r input; do
    pactl move-sink-input "$input" "$new_sink"
done

