
: '
Crear un script en BASH que permita consultar los datos de un usuario de GITHUB. Los datos del usuario seran descargado de un webservice. Luego este debera de escribir un log con algunos de los datos del usario.

Tareas a realizar por el script:

    Lea la variable GITHUB_USER
    Consulte la URL https://api.github.com/users/ concatenando el valor de la variable GITHUB_USER al final
    Imprimir el mensaje: “Hola <github_user>. User ID: <id>. Cuenta fue creada el: <created_at>.” Los valores entre los signos <> deben de ser tomados del JSON colsutado previamente.
    Crear un log file en /tmp/<fecha>/saludos.log con la salida del mensaje anterior. Donde <fecha> corresponde a la fecha del día de ejecución del script
    Crear un cronjob para que el script se ejecute cada 5 minutos
'

GITHUB_USER="JHinestroza"  
URL=$(curl -s "https://api.github.com/users/$GITHUB_USER")

USER_ID=$(echo "$URL" | jq -r '.id')  #jq -r hace que imprima solo el valro de la clave json
CREATED_AT=$(echo "$URL" | jq -r '.created_at')

MESSAGE="Hola $GITHUB_USER. User ID: $USER_ID. Cuenta fue creada el: $CREATED_AT."
echo "$MESSAGE"

DATE=$(date +%F)  
LOG_DIR="/tmp/$DATE"
mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/saludos.log"
echo "$MESSAGE" > "$LOG_FILE"           

#cronjob cada 5 minutos
#*/5 * * * * /home/hinestroza/Desktop/SO1_actividades_202100316/Actividad2/actividad2.sh
