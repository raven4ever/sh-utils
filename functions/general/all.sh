consolelog() {
  local color
  local ts

  ts="[$(date -u +'%Y-%m-%d %H:%M:%S')] "

  color_reset='\e[0m'

  case "${2}" in
  success)
    color='\e[0;32m'
    ;;
  error)
    color='\e[1;31m'
    ;;
  *)
    color='\e[0;37m'
    ;;
  esac

  if [[ ! -z "${1}" ]]; then
    printf "${color}%s%s: %s${color_reset}\n" "${ts}" "${0##*/}" "${1}"
  fi

  return 0
}
