#! /usr/bin/env bash

assert (){
    text=$1
    string=$2

    if [[ $text == *"$string"* ]];
    then
        echo "'$string': passed"
    else
        echo "'$string': not found in text:"
        echo "$text"
        exit 99
    fi
}

username="username2"    #$(shuf -n1 /usr/share/dict/words)
password="password2"    #$(shuf -n1 /usr/share/dict/words)
wrongpassword="wrongPw"

homepage () { curl -s https://hackersportfolio.duckdns.org; }
register () { curl -s -d "username=$1&password=$2" -X POST https://hackersportfolio.duckdns.org/register; }
login () { curl -s -d "username=$1&password=$2" -X POST https://hackersportfolio.duckdns.org/login; }

assert "$(homepage)" "Linda"
assert "$(register "" "$password")" "Username is required."
assert "$(register "$username" "")" "Password is required."
assert "$(register "$username" "$password")" "User ${username} created successfully."
assert "$(register "$username" "$password")" "User ${username} is already registered."
assert "$(login "" "$password")" "Incorrect username."
assert "$(login "$username" "")" "Incorrect password."
assert "$(login "$username" "$password")" "Login Successful."