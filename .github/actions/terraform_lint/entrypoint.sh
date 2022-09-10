function check(){
  local __resultvar=$1
  local result=$(terraform fmt -check -recursive -diff)

  if [[ -n "$(terraform fmt -check -recursive -diff)" ]]; then
    echo "$result"
  fi
}

check result
echo $result
