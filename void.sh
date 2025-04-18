#!/bin/bash

# --------------------------------------
# Made by: Emad Adel
# Description: This script sets up Void Linux environment and packages
# --------------------------------------

tput civis
trap "tput cnorm; clear; exit" INT TERM EXIT

declare -A menus
menus["main"]="Environment Packages Install"
menus["Environment"]="KDE"
menus["Packages"]="Loading..."

declare -A selected
declare -A actions
current_menu="main"
cursor=0
menu_stack=()

# Define actions for each environment setup
run_kde() {
    curl -s https://raw.githubusercontent.com/emadadel4/Void-Linux/refs/heads/main/scripts/env/kde/setup.sh | bash
}

# Map actions
actions["KDE"]="run_kde"

# Function to load packages from JSON URL
load_packages() {
    echo -e "\nLoading Packages..."
    menus["Packages"]=$(curl -s https://raw.githubusercontent.com/emadadel4/Void-Linux/refs/heads/main/packages/pkg.json | sed 's/\[//g' | sed 's/\]//g' | sed 's/","/ /g' | sed 's/"//g' | sed 's/,/ /g')
}

# Draw the menu with dynamic items
draw_menu() {
    clear
    echo -e "\e[1;33m       _________"
    echo -e "      \\         /"
    echo -e "       \\       /"
    echo -e "        \\     /"
    echo -e "         \\   /"
    echo -e "          \\ /"
    echo -e "           V\n"
    echo -e "   VOID SETUP"
    echo -e "   Made by: Emad Adel\e[0m"
    echo -e "\nUse ↑↓ arrows to navigate, ENTER/SPACE to select, Q to back.\n"
    
    local items=(${menus[$current_menu]})
    for i in "${!items[@]}"; do
        local name="${items[$i]}"
        local mark=""
        
        if [[ "$current_menu" == "Packages" || "$current_menu" == "Environment" ]]; then
            if [[ "${selected[$name]}" == "1" ]]; then
                mark="[*]"
            else
                mark="[ ]"
            fi
        elif [[ -z "${menus[$name]}" && "${actions[$name]}" != "" ]]; then
            mark="[ ]"
            [[ "${selected[$name]}" == "1" ]] && mark="[*]"
        fi

        if [[ "$i" == "$cursor" ]]; then
            echo -e "> $mark $name"
        else
            echo "  $mark $name"
        fi
    done
}

# Execute the selected environment installation or package installation
execute_selected() {
    clear
    echo "Installing selected packages..."
    echo

    package_list=()

    for name in "${!selected[@]}"; do
        if [[ "${selected[$name]}" == "1" ]]; then
            if [[ "${actions[$name]}" != "" ]]; then
                echo "→ $name"
                ${actions[$name]}
                echo
            elif [[ " ${menus[Packages]} " == *" $name "* ]]; then
                package_list+=("$name")
            fi
        fi
    done

    if [[ ${#package_list[@]} -gt 0 ]]; then
        sudo xbps-install -S "${package_list[@]}"
        echo
    fi

    selected=()

    read -p "Done. Press any key to continue..." -n1
}

# Main loop to handle navigation and selection
while true; do
    draw_menu
    IFS= read -rsn1 key
    [[ $key == $'\x1b' ]] && read -rsn2 key

    case "$key" in
        '[A') # Up
            ((cursor > 0)) && ((cursor--)) ;;
        '[B') # Down
            items=(${menus[$current_menu]})
            if ((cursor < ${#items[@]} - 1)); then
                ((cursor++))
            fi
            ;;
        'q'|'Q') # q/Q = Go back to previous menu
            if [[ ${#menu_stack[@]} -gt 0 ]]; then
                current_menu="${menu_stack[-1]}"
                unset 'menu_stack[-1]'
                cursor=0
            fi
            ;;
        '') # Enter
            item=(${menus[$current_menu]})
            selected_item="${item[$cursor]}"
            if [[ "$selected_item" == "Install" && "$current_menu" == "main" ]]; then
                execute_selected
            elif [[ -n "${menus[$selected_item]}" ]]; then
                if [[ "$selected_item" == "Packages" && "${menus[$selected_item]}" == "Loading..." ]]; then
                    load_packages
                fi
                menu_stack+=("$current_menu")
                current_menu="$selected_item"
                cursor=0
            fi
            ;;
        ' ') # Space = Toggle selection
            item=(${menus[$current_menu]})
            name="${item[$cursor]}"
            if [[ "$current_menu" == "Packages" || "$current_menu" == "Environment" ]]; then
                if [[ "${selected[$name]}" == "1" ]]; then
                    unset selected["$name"]
                else
                    selected["$name"]=1
                fi
            fi
            ;;
    esac
done
