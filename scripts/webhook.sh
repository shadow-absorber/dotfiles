#!/bin/bash

content="test"
username="Shadow Bot"
avatar="https://cdn.discordapp.com/attachments/177089535576899584/388321493941223425/shadow.5.png"
webhook=""


# handle user options
getopt --test > /dev/null
if [[ $? -ne 4 ]]; then
    echo "I’m sorry, `getopt --test` failed in this environment."
    exit 1
fi
OPTS=c:u:a:w:
LONGOPTS=content:,username:,avatar:,webhook:
TEMP=$(getopt -o $OPTS -l $LONGOPTS -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$TEMP"
while true; do
    case "$1" in
        -c|--content)
			content=$2
			shift 2
            ;;
        -u|--username)
            username=$2
            shift 2
            ;;
        -a|--avatar)
            avatar=$2
            shift 2
            ;;
        -w|--webhook)
            webhook=$2
            shift 2
            ;;
        --) shift; break;;
        *) echo "Internal Error!"; exit 1;;
    esac
done





json=$(cat <<EOF
{
"username":"$username",
"avatar_url":"$avatar",
"content": "$content"
}
EOF
)

echo "Sending Discord alert"
sleep 0.5
discordsend=$(curl -sSL -H "Content-Type: application/json" -X POST -d """${json}""" $webhook)
${discordsend}
