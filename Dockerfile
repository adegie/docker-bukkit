FROM java:8
RUN mkdir /minecraft-workspace /minecraft /data
RUN wget -O /minecraft-workspace/BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

RUN cd /minecraft-workspace/ && java -jar BuildTools.jar --rev latest
RUN mv /minecraft-workspace/craftbukkit-*.jar /minecraft
RUN rm -rf /minecraft-workspace
RUN apt-get -y update
RUN apt-get -y install screen
ADD download_plugins.sh /data/plugins/download_plugins.sh
RUN cd /data/plugins && ./download_plugins.sh

EXPOSE 25565
WORKDIR /data

ADD start-minecraft.sh /root/start-minecraft.sh
ADD eula.txt /data/eula.txt
ENTRYPOINT ["/bin/bash", "/root/start-minecraft.sh"]
