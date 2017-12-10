FROM java:8
RUN mkdir /minecraft-workspace /minecraft /data /minecraft-plugins
RUN wget -O /minecraft-workspace/BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

RUN cd /minecraft-workspace/ && java -jar BuildTools.jar --rev latest
RUN mv /minecraft-workspace/craftbukkit-*.jar /minecraft
RUN rm -rf /minecraft-workspace
RUN apt-get -y update
RUN apt-get -y install screen
ADD gdrive-linux-x64 /bin/gdrive

ADD copy_plugins.sh /root/copy_plugins.sh

ADD download_plugins.sh /minecraft-plugins/download_plugins.sh
# RUN cd /minecraft-plugins && ./download_plugins.sh #disabled for now, rellying on manual plugins

ADD manual_plugins/*.jar /minecraft-plugins/

EXPOSE 25565
WORKDIR /data

ADD start-minecraft.sh /root/start-minecraft.sh
ADD eula.txt /data/eula.txt
ENTRYPOINT ["/bin/bash", "/root/start-minecraft.sh"]
