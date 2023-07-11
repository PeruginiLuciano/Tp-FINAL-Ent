El archivo Dockerfile contiene las intrucciones utilizadas por Docker para construir una imagen de contenedor.
Luego construimos la imagen con el comando "docker build -t nombre ." en nuestro caso el nombre sera tp_entorno
Una vez que tenemos la imagen podremos correr un contenedor con el siguiente comando  
docker run -v "$(pwd)/Script/comprimido:/Script/comprimido" -it tp_entorno
el -v y la ruta es porque necesitamos hacer un mapeo para poder ver el resultado de nuestro tp, que es un comprimido que contiene las imagenes procesadas con archivo nombres

COMANDOS:

sudo docker build -t tp_entorno .

sudo docker run -v "$(pwd)/Script/comprimido:/Script/comprimido" -it tp_entorno
