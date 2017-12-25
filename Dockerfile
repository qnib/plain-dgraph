FROM qnib/alplain-golang AS build

ARG DGRAPH_URL=https://github.com/dgraph-io/dgraph
ARG DGRAPH_VER=1.0.1
WORKDIR /usr/local/src/github.com/dgraph-io/dgraph
RUN apk --no-cache add wget \
 && wget -qO - ${DGRAPH_URL}/archive/v${DGRAPH_VER}.tar.gz |tar xfz - --strip-components=1
WORKDIR /usr/local/src/github.com/dgraph-io/dgraph/dgraph
RUN govendor fetch +m
RUN go build

FROM qnib/alplain-init
COPY --from=build /usr/local/src/github.com/dgraph-io/dgraph/dgraph/dgraph /usr/local/bin/
