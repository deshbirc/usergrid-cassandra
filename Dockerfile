#
# Cassandra Dockerfile for Usergrid
#
# https://github.com/yep/usergrid-cassandra
# 

FROM deshbir/usergrid-java

ENV DEBIAN_FRONTEND noninteractive
WORKDIR /root

# add datastax repository and install cassandra
RUN echo "deb http://www.apache.org/dist/cassandra/debian 22x main" | tee -a /etc/apt/sources.list.d/cassandra.sources.list
RUN gpg --keyserver pgp.mit.edu --recv-keys 749D6EEC0353B12C
RUN gpg --export --armor 749D6EEC0353B12C | sudo apt-key add -
RUN apt-get update
RUN sudo apt-get install -yq cassandra
RUN rm -rf /var/lib/apt/lists/*

# persist database and logs between container starts
VOLUME ["/var/lib/cassandra", "/var/log/cassandra"]

# set default command when starting container with "docker run"
CMD /root/run.sh

# available ports:
#  7000 intra-node communication
#  7001 intra-node communication over tls
#  7199 jmx
#  9042 cassandra native transport (cassandra query language, cql)
#  9160 cassandra thrift interface (legacy)
EXPOSE 9042 9160

COPY run.sh /root/run.sh 
