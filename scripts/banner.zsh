# Login banner - works with or without fortune/cowsay
# Falls back to the starfield ASCII art

_banner_starfield() {
  local width=55 height=9
  local -a symbols=("★" "✦" "♫" "♪" "." "·" "✧" "°")
  for (( y=0; y<height; y++ )); do
    local line=""
    for (( x=0; x<width; x++ )); do
      if (( RANDOM % 100 < 10 )); then
        line+="${symbols[$(( RANDOM % ${#symbols[@]} + 1 ))]}"
      else
        line+=" "
      fi
    done
    echo "$line"
  done
}

_banner_cowsay() {
  if command -v shuf &> /dev/null; then
    fortune | cowsay -f "$(cowsay -l | tail -n +2 | tr ' ' '\n' | shuf -n 1)"
  else
    fortune | cowsay -r
  fi
}

_banner_show() {
  local roll=$(( RANDOM % 10 ))

  # If fortune+cowsay available, show them ~70% of the time
  if command -v fortune &> /dev/null && command -v cowsay &> /dev/null && (( roll < 7 )); then
    _banner_cowsay
  else
    _banner_starfield
  fi
}

_banner_show
