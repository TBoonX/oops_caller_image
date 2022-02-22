FROM ubuntu:latest
LABEL version="0.1"
LABEL maintainer="aksw.org/KurtJunghanns"

RUN apt-get update && apt-get install -y git curl automake build-essential libtool gtk-doc-tools autopoint bison libxml2 libxml2-dev libraptor2-0

#install flex
WORKDIR /
RUN curl -L https://github.com/westes/flex/releases/download/v2.6.3/flex-2.6.3.tar.gz > flex.tar.gz
RUN tar -xzvf flex.tar.gz
WORKDIR flex-2.6.3
RUN ./autogen.sh
RUN ./configure && make && make install

# CMD flex -h

#install rapper
WORKDIR /
RUN git clone git://github.com/dajobe/raptor.git
WORKDIR raptor
RUN ./autogen.sh
RUN make && make check && make install

#add script
ADD script.sh /script.sh
RUN chmod 777 /script.sh

ENTRYPOINT ["/bin/sh", "/script.sh"]
