FROM golang

RUN git clone --depth 1 --branch "v0.08" https://github.com/tenortim/gostats
WORKDIR /go/gostats
RUN go build
ADD idic.toml /go/gostats/idic.toml.master
ADD run.sh /go/gostats/run.sh
CMD [ "/bin/bash", "/go/gostats/run.sh" ]