FROM qnib/dplain-init

ARG DGRAPH_URL=https://github.com/dgraph-io/dgraph
ARG DGRAPH_VER=v1.0.1
RUN apt-get update \
 && apt-get install -y wget \
 && wget -qO - \
    ${DGRAPH_URL}/releases/download/${DGRAPH_VER}/dgraph-linux-amd64-${DGRAPH_VER}.tar.gz \
    |tar xfz - -C /usr/bin/
COPY bin/dgraph.sh /opt/qnib/dgraph/bin/
CMD ["/opt/qnib/dgraph/bin/dgraph.sh", "zero"]
