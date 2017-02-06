FROM base

# Install Zookeeper

RUN wget http://apache.mirrors.pair.com/zookeeper/stable/zookeeper-3.4.9.tar.gz -O /zookeeper.tgz
RUN tar -xzvf /zookeeper.tgz
RUN mv /zookeeper-3.4.9 /zookeeper
RUN mkdir /zookeeper/data
RUN echo -e "tickTime=2000\ndataDir=/zookeeper/data\nclientPort=2181\ninitLimit=5\nsyncLimit=2" > /zookeeper/conf/zoo.cfg 


# Install Storm

RUN wget http://mirror.jax.hugeserver.com/apache/storm/apache-storm-1.0.2/apache-storm-1.0.2.tar.gz -O /storm.tgz
RUN tar -xzvf /storm.tgz
RUN mv apache-storm-1.0.2 /storm
RUN mkdir /storm/data
RUN echo -e 'storm.zookeeper.servers:\n - "localhost"\nstorm.local.dir: "/storm/data"\nnimbus.host: "localhost"\nsupervisor.slots.ports:\n - 6700\n - 6701\n - 6702\n - 6703' > /storm/conf/storm.yaml


# Install Python Streamparse

RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O /bin/lein
RUN chmod a+x /bin/lein
RUN /bin/lein
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
RUN python get-pip.py
RUN yum -y update
RUN yum -y install python-devel
RUN yum -y install gcc
RUN yum -y install openssl-devel
RUN pip install streamparse 


ADD assets /assets
ADD assets/start_storm.sh /start_storm.sh
ADD assets/storm.yaml /storm/conf/storm.yaml
