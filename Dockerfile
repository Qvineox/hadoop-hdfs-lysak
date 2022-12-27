FROM openjdk:11

# установка переменных для удобства работы
# ENV JDK_VER=11.0.17
ENV HADOOP_VER=3.3.4
# ENV JDK_TAR_NAME=jdk-11.0.17_linux-x64_bin.tar.gz
ENV HADOOP_TAR_NAME=hadoop-3.3.4.tar.gz

# обновление и установка bash (в alpine нет bash по умолчанию), установка python3
# RUN apk update

RUN apt update
RUN apt install python3

# рабочая директория
WORKDIR /opt

# перенос необходимого ПО, команда ADD автоматически разархивирует
# ADD ./software/${JDK_TAR_NAME} .
ADD ./software/${HADOOP_TAR_NAME} .

# в alpine можно установить JDK как пакет более просто
# RUN apk add openjdk11

# проверка установки JAVA, поиск и установка JAVA_HOME

# ENV PATH=$PATH:$JAVA_HOME:$JAVA_HOME/bin

# RUN which java

# RUN ls /opt
#
# ENV JAVA_HOME=/opt/java-11.0.17
# ENV PATH=$PATH:$JAVA_HOME:$JAVA_HOME/bin

# ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
# RUN export JAVA_HOME

# RUN ls /usr/lib/jvm

# ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk/
# RUN export JAVA_HOME

# ENV PATH=$PATH:$JAVA_HOME:$JAVA_HOME/bin

RUN java --version

# установка системных переменных HADOOP
ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VER}
ENV HADOOP_STREAMING_JAR=$HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.3.4.jar
ENV PATH=$PATH:$HADOOP_HOME
ENV PATH=$PATH:$HADOOP_HOME/bin

# перенос файлов конфигурации HADOOP
ADD config/hadoop-env.sh $HADOOP_HOME/etc/hadoop/
ADD config/core-site.xml $HADOOP_HOME/etc/hadoop/

# можно протестировать работу HADOOP с помощью команды ниже
# RUN $HADOOP_HOME/bin/hadoop

# установка SSH
RUN apt-get update && apt-get install openssh-server
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

CMD [ "sh", "-c", "service ssh start; bash"]
