FROM ubuntu
RUN apt-get update && apt-get install -y imagemagick wget tar gzip 
COPY Script/generar.sh Script/descomprimir.sh Script/procesar.sh Script/comprimir.sh Script/menu.sh Script/personas.sh /Script/
ENV TERM=xterm
CMD ["/bin/bash", "Script/menu.sh"]


