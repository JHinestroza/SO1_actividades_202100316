
echo "Creando usuarios..."
sudo useradd usuario1
sudo useradd usuario2
sudo useradd usuario3


echo "Asignando contraseñas a los usuarios..."
echo "usuario1:password1" | sudo chpasswd
echo "usuario2:password2" | sudo chpasswd
echo "usuario3:password3" | sudo chpasswd

echo "Información de usuario1:"
id usuario1


echo "Eliminando usuario3 pero conservando su directorio principal..."
sudo userdel usuario3

echo "Creando grupos..."
sudo groupadd grupo1
sudo groupadd grupo2

echo "Agregando usuarios a grupos..."
sudo usermod -a -G grupo1 usuario1
sudo usermod -a -G grupo2 usuario2

echo "Verificando membresía de los usuarios en los grupos..."
groups usuario1
groups usuario2


echo "Eliminando grupo2..."
sudo groupdel grupo2

echo "Creando archivos y directorios como usuario1..."
sudo -u usuario1 bash -c '
    touch /home/usuario1/archivo1.txt
    echo "Contenido del archivo1.txt" > /home/usuario1/archivo1.txt
    mkdir /home/usuario1/directorio1
    touch /home/usuario1/directorio1/archivo2.txt
    echo "Contenido del archivo2.txt" > /home/usuario1/directorio1/archivo2.txt
'

echo "Verificando permisos del archivo y directorio..."
sudo -u usuario1 bash -c '
    ls -l /home/usuario1/archivo1.txt
    ls -ld /home/usuario1/directorio1
'

echo "Modificando permisos de archivo1.txt..."
sudo chmod 640 /home/usuario1/archivo1.txt

echo "Modificando permisos de archivo2.txt..."
sudo chmod u+x /home/usuario1/directorio1/archivo2.txt

echo "Cambiando el grupo propietario de archivo2.txt a grupo1..."
sudo chgrp grupo1 /home/usuario1/directorio1/archivo2.txt

echo "Configurando permisos de directorio1..."
sudo chmod 751 /home/usuario1/directorio1

echo "Intentando acceder a archivos como usuario2..."
sudo -u usuario2 bash -c '
    echo "Intentando leer archivo1.txt..."
    cat /home/usuario1/archivo1.txt
    echo "Intentando leer archivo2.txt..."
    cat /home/usuario1/directorio1/archivo2.txt
'

echo "Verificación final de permisos y propietarios..."
sudo -u usuario1 bash -c '
    ls -l /home/usuario1/archivo1.txt
    ls -ld /home/usuario1/directorio1
'

echo "Script completado."
