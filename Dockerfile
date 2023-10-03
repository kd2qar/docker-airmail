FROM scottyhardy/docker-wine

env USER_NAME=airmail
env USER_UID=1000
env USER_GID=1000
#env USER_PASSWD=airmail
env USER_SUDO=yes
ENV RDP_SERVER=yes
env TZ=America/New_York



RUN mkdir /setup&& chown 1000:1000 /setup
WORKDIR /setup
RUN wget http://siriuscyber.net/ham/amhc34062b.exe
RUN chown 1000:1000 amhc34062b.exe
WORKDIR /root


#RUN >>EOF \
#test \
#>>EOF > setup-airmail.desktop

RUN echo  $'\
DROP USER IF EXISTS  l4om@localhost;\n\
EOF' > /setup/x.sql

#DROP USER IF EXISTS  l4om@'%'; \
#CREATE USER l4om@localhost IDENTIFIED BY  'l4om'; \
#CREATE USER l4om IDENTIFIED BY 'l4om'; \
#GRANT ALL PRIVILEGES ON *.* TO l4om@localhost  WITH GRANT OPTION; \
#GRANT ALL PRIVILEGES ON *.* TO l4om  WITH GRANT OPTION;  \
#EOF


RUN echo $'#!/bin/bash\n\
pushd /setup\n\
wine amhc34062b.exe\n\
popd'>/setup/setup.sh &&\
chmod +x /setup/setup.sh && \
echo $'amhc34062b.exe' >/setup/setup.cmd && \
chown 1000:1000 /setup/*;

RUN echo $'[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Terminal=false\n\
Exec=/setup/setup.sh\n\
Name=Setup Airmail\n\
Comment=airmail\n\
Icon=/home/linuxconfig/Downloads/icon.png' >/setup/setup_desk.desktop

ENTRYPOINT ["/usr/bin/entrypoint" ]

