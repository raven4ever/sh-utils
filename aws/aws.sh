aws-encrypt() {
  local reset="\033[0m"
  local red="\033[31m"
  local aws_profile="${1}"
  local environment_to_use="${2}"
  local plaintext_to_encrypt="${3}"
  if [[ -z "${1}" ]]; then
    echo "${red}usage: aws-encrypt profile env plaintext${reset}"
    return
  fi
  if ! command -v aws > /dev/null; then
    echo "${red}install awscli${reset}"
    return
  fi

  aws \
    --profile "${aws_profile}" \
    kms encrypt \
    --key-id "alias/${environment_to_use}/params" \
    --plaintext "${plaintext_to_encrypt}" \
    --output text \
    --query CiphertextBlob
}

aws-decrypt() {
  local reset="\033[0m"
  local red="\033[31m"
  local aws_profile="${1}"
  local plaintext_to_decrypt="${2}"
  if [[ -z "${1}" ]]; then
    echo "${red}usage: aws-decrypt profile encryptedblob${reset}"
    return
  fi
  if ! command -v aws > /dev/null; then
    echo "${red}install awscli${reset}"
    return
  fi

  aws \
    --profile "${aws_profile}" \
    kms decrypt \
    --ciphertext-blob fileb://<(echo "${plaintext_to_decrypt}" | base64 -d) \
    --output text \
    --query Plaintext \
    | base64 -d

  echo ""
}
