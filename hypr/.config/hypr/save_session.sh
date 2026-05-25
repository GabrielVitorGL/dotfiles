#!/bin/bash
RESTORE_SCRIPT="/tmp/restore_session.sh"

echo "#!/bin/bash" > $RESTORE_SCRIPT
# Aumentamos para 6 segundos para dar tempo de os 3 monitores ligarem fisicamente
echo "sleep 6" >> $RESTORE_SCRIPT

# Garante que o comando funcione mesmo se for chamado pelo sistema (na hora de desligar a VM)
export XDG_RUNTIME_DIR=/run/user/1000
export WAYLAND_DISPLAY=wayland-1

hyprctl clients -j | jq -c '.[] | select(.mapped == true)' | while read -r client; do
    workspace=$(echo "$client" | jq -r '.workspace.id')
    class=$(echo "$client" | jq -r '.class')

    if [ "$workspace" -lt 1 ]; then continue; fi

    cmd=$(echo "$class" | tr '[:upper:]' '[:lower:]')
    
    case "$cmd" in
        *"code"*) cmd="code" ;;
        *"discord"*) cmd="discord" ;;
        *"brave"*) cmd="brave-origin-beta --restore-last-session" ;; # O TRUQUE DA RESTAURAÇÃO FORÇADA AQUI!
        *"chrome"*) cmd="google-chrome-stable --restore-last-session" ;;
        *"zen"*) cmd="zen-browser" ;;
        *"firefox"*) cmd="firefox" ;;
    esac

    echo "hyprctl dispatch exec \"[workspace $workspace] $cmd\"" >> $RESTORE_SCRIPT
done

echo "rm -f $RESTORE_SCRIPT" >> $RESTORE_SCRIPT
chmod +x $RESTORE_SCRIPT
