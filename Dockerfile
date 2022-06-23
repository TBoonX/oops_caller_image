FROM ubuntu:latest
LABEL version="0.4"
LABEL maintainer="aksw.org/KurtJunghanns"

# Set time zone
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y git curl raptor2-utils

#install flex
WORKDIR /
#RUN curl -L https://github.com/westes/flex/releases/download/v2.6.3/flex-2.6.3.tar.gz > flex.tar.gz
#RUN tar -xzvf flex.tar.gz
#WORKDIR flex-2.6.3
#RUN ./autogen.sh
#RUN ./configure && make && make install

# CMD flex -h

#install rapper
#WORKDIR /
#RUN git clone git://github.com/dajobe/raptor.git
#WORKDIR raptor
#RUN ./autogen.sh
#RUN make && make install

#add script
ADD script.sh /script.sh
RUN chmod 777 /script.sh

ENTRYPOINT ["/bin/sh", "/script.sh"]
