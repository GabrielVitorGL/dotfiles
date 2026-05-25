#!/bin/bash
# Dá um pequeno respiro para o Hyprland carregar todos os monitores e aplicar o config padrão
sleep 2

if [ -f /tmp/modo_vm_ativo ]; then
  # MODO VM: O DP-6 sumiu. Vamos puxar o DP-1 para o pixel 1920
  # (Colando ele exatamente do lado direito do HDMI-A-1)
  hyprctl keyword monitor DP-1,1920x1080@144,1920x0,1
  sleep 0.5

  killall -9 waybar
  uwsm app -- waybar &

  hyprctl dispatch focusmonitor HDMI-A-1
  hyprctl dispatch workspace 1
else
  # MODO NORMAL: Garante que o DP-1 volte/permaneça na posição original,
  # deixando os 2560 pixels livres no meio para o DP-6.
  hyprctl keyword monitor DP-1,1920x1080@144,4480x0,1
fi
