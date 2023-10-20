FROM golang

RUN git clone https://github.com/tenortim/gostats.git
WORKDIR /go/gostats
RUN go build
ADD idic.toml /go/gostats/idic.toml.master
ADD run.sh /go/gostats/run.sh
CMD [ "/bin/bash", "/go/gostats/run.sh" ]

