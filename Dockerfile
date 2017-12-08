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
RUN cd /minecraft-plugins && ./download_plugins.sh

ADD manual_plugins/towny.jar /minecraft-plugins/towny.jar

EXPOSE 25565
WORKDIR /data

ADD start-minecraft.sh /root/start-minecraft.sh
ADD eula.txt /data/eula.txt
ENTRYPOINT ["screen -S minecraft", "/root/start-minecraft.sh"]
