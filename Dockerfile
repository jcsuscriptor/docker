# https://github.com/zorino/docker-es-kibi

# Linux OS
FROM elasticsearch:2.2.0

# Maintainer
MAINTAINER zorino <maximilien1er@gmail.com>

# Update
# RUN yum -y update && yum clean all

# Create volume for graph data
RUN apt-get update && apt-get clean \
 && curl -sL https://deb.nodesource.com/setup_4.x | bash - \
 && apt-get install -y nodejs \
 && cd /opt && wget http://bit.do/kibi-0-3-2-demo-lite-linux-x64-zip \
 && unzip kibi-0-3-2-demo-lite-linux-x64-zip \
 && ln -s kibi-0-3-2-demo-lite-linux-x64-zip kibi \
 && /usr/share/elasticsearch/bin/plugin install solutions.siren/siren-join/2.1.2

COPY entrypoint.sh /opt/
RUN chmod 755 /opt/entrypoint.sh
 
# Exec on start
ENTRYPOINT ["/bin/bash", "/opt/entrypoint.sh"]

# Expose Default Port
EXPOSE 9200 9300 5601
