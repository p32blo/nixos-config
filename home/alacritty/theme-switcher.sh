set -eu

theme_dir="$HOME/.config/alacritty"
theme_link="$theme_dir/theme.toml"
light_theme="$theme_dir/catppuccin-latte.toml"
dark_theme="$theme_dir/catppuccin-mocha.toml"

mkdir -p "$theme_dir"

case "${DARKMODE:-}" in
  1)
    theme="$dark_theme"
    ;;
  0)
    theme="$light_theme"
    ;;
  *)
    if /usr/bin/defaults read -g AppleInterfaceStyle >/dev/null 2>&1; then
      theme="$dark_theme"
    else
      theme="$light_theme"
    fi
    ;;
esac

ln -sfn "$theme" "$theme_link"
