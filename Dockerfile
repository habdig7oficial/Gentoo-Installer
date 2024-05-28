FROM crystallang/crystal as base 

WORKDIR /tmp/ncurses

RUN apt update
RUN apt install wget -y

RUN wget https://ftp.gnu.org/gnu/ncurses/ncurses-6.5.tar.gz
RUN tar --strip-components=1 -xvf ncurses-*.tar.gz 
RUN ./configure
RUN make
RUN make install

##

WORKDIR /usr/src/program

COPY ./ ./

RUN shards install 

#CMD ["crystal", "run", "src/trigger.cr"] 
CMD ["./trigger"]

#CRYSTAL_LIBRARY_PATH="lib/x86_64-linux-gnu/" crystal build src/trigger.cr --static && ./trigger
## sudo docker build --progress plain -t cr-gein . && sudo docker run --env TERM=xterm-256color cr-gen
