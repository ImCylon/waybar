#!/bin/bash

token=`cat ${HOME}/.dotfiles/waybar/scripts/notifications.token`
count=`curl -u ImCylon:${token} https://api.github.com/notifications | jq '. | length'`

if [[ "$count" != "0" ]]; then
    echo '{"text":'$count',"tooltip":"$tooltip","class":"$class"}'
fi
