FROM base-image:1

# директории для хранилища namenode
RUN mkdir /opt/hdfs
RUN mkdir /opt/hdfs/namenode

# перенос файлов конфигурации HADOOP
ADD config/hdfs-site.xml $HADOOP_HOME/etc/hadoop/

RUN hdfs namenode -format

CMD hdfs namenode