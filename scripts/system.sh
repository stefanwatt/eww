#!/run/current-system/sw/bin/bash

# Function to truncate long strings
  truncate() {
      if [ ${#1} -gt 50 ]; then
          echo "${1:0:47}..."
      else
          echo "$1"
      fi
  }

  # Run neofetch and capture the output
  neofetch_output=$(neofetch --stdout)

  # Function to extract value based on key
  get_value() {
      echo "$neofetch_output" | grep "$1" | cut -d ':' -f 2- | sed 's/^[ \t]*//'
  }

  # Check the argument and echo the corresponding value
  case "$1" in
      --os)
          echo "  $(truncate "$(get_value "OS")")"
          ;;
      --host)
          echo "󰟀  $(get_value "Host")"
          ;;
      --kernel)
          echo "󰌽  $(get_value "Kernel")"
          ;;
      --uptime)
          echo "󰅐  $(get_value "Uptime")"
          ;;
      --packages)
          echo "󰏓  $(get_value "Packages")"
          ;;
      --shell)
          echo "󰆍  $(get_value "Shell")"
          ;;
      --resolution)
          echo "󱣴  $(get_value "Resolution")"
          ;;
      --de)
          echo "  $(get_value "DE")"
          ;;
      --wm)
          echo "󰖲  $(get_value "WM")"
          ;;
      --theme)
          echo "󰔎  $(truncate "$(get_value "Theme")")"
          ;;
      --terminal)
          echo "  $(get_value "Terminal")"
          ;;
      --cpu)
          echo "󰻠  $(truncate "$(get_value "CPU")")"
          ;;
      --gpu)
          echo "󰓡  $(truncate "$(get_value "GPU")")"
          ;;
      --memory)
          echo "󰍛  $(get_value "Memory")"
          ;;
      *)
          echo "Invalid argument. Use one of: --os, --host, --kernel, --uptime, --packages, --shell, --resolution, --de, --wm, --theme, --terminal, --cpu, --gpu, --memory"
          exit 1
          ;;
  esac
