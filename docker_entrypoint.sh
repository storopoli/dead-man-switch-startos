#!/bin/sh

set -ea


_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$dead_man_switch_web_process" 2>/dev/null
}

UI_TOR_ADDRESS="$(yq e '.tor-address' /root/start9/config.yaml)"
UI_LAN_ADDRESS="$(echo $UI_TOR_ADDRESS | sed 's/\.onion/\.local/')"
UI_PASSWORD="$(yq e '.password' /root/start9/config.yaml)"
SMTP_SERVER="$(yq e '.smtp.server' /root/start9/config.yaml)"
SMTP_PORT="$(yq e '.smtp.port' /root/start9/config.yaml)"
SMTP_USERNAME="$(yq e '.smtp.username' /root/start9/config.yaml)"
SMTP_PASSWORD="$(yq e '.smtp.password' /root/start9/config.yaml)"
EMAIL_FROM="$(yq e '.email.from' /root/start9/config.yaml)"
EMAIL_TO="$(yq e '.email.to' /root/start9/config.yaml)"
EMAIL_SUBJECT="$(yq e '.email.subject' /root/start9/config.yaml)"
EMAIL_SUBJECT_WARNING="$(yq e '.email.subject_warning' /root/start9/config.yaml)"
EMAIL_MESSAGE="$(yq e '.email.message' /root/start9/config.yaml)"
EMAIL_MESSAGE_WARNING="$(yq e '.email.message_warning' /root/start9/config.yaml)"
TIMER_DEAD_MAN_SWITCH="$(yq e '.timer.dead_man' /root/start9/config.yaml)"
TIMER_WARNING="$(yq e '.timer.warning' /root/start9/config.yaml)"
export UI_TOR_ADDRESS
export UI_LAN_ADDRESS
export UI_PASSWORD
export SMTP_SERVER
export SMTP_PORT
export SMTP_USERNAME
export SMTP_PASSWORD
export EMAIL_FROM
export EMAIL_TO
export EMAIL_SUBJECT
export EMAIL_SUBJECT_WARNING
export EMAIL_MESSAGE
export EMAIL_MESSAGE_WARNING
export TIMER_DEAD_MAN_SWITCH
export TIMER_WARNING

echo "Writing config file"
mkdir -p /root/.config/deadman
touch /root/.config/deadman/config.toml
{
    echo "web_password = \"$UI_PASSWORD\"" 
    echo "username = \"$SMTP_USERNAME\"" 
    echo "password = \"$SMTP_PASSWORD\"" 
    echo "smtp_server = \"$SMTP_SERVER\"" 
    echo "smtp_port = $SMTP_PORT" 
    echo "from = \"$EMAIL_FROM\"" 
    echo "to = \"$EMAIL_TO\"" 
    echo "subject = \"$EMAIL_SUBJECT\"" 
    echo "subject_warning = \"$EMAIL_SUBJECT_WARNING\"" 
    echo "message = \"$EMAIL_MESSAGE\"" 
    echo "message_warning = \"$EMAIL_MESSAGE_WARNING\"" 
    echo "timer_dead_man = $TIMER_DEAD_MAN_SWITCH" 
    echo "timer_warning = $TIMER_WARNING" 
} > /root/.config/deadman/config.toml
echo "All configuration done"

echo "Starting dead_man_switch_web"
dead_man_switch_web &
dead_man_switch_web_process=$!

trap _term TERM
wait $dead_man_switch_web_process