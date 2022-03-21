FROM steamcmd/steamcmd as download
ARG BRANCH=public
RUN mkdir -p /opt/stationeers
RUN steamcmd +force_install_dir /opt/stationeers +login anonymous +app_update 600760 -beta $BRANCH +quit

FROM ubuntu:20.04
RUN apt-get update && \
  apt-get install -y pwgen gosu

COPY --from=download /opt/stationeers /opt/stationeers/

EXPOSE 27500/udp 27500/tcp 27015/udp

ENV PROFILE_DIR=/var/opt/stationeers \
    AUTOSAVEINTERVAL=600 \
    WORLDNAME=Stationeers \
    WORLDTYPE=Mars \
    SERVERNAME="A Stationeers Server"

VOLUME $PROFILE_DIR

WORKDIR /opt/stationeers

COPY ./start.sh ./

CMD [ "./start.sh" ]