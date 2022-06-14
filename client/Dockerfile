from ubuntu:22.04
RUN apt update -y
ARG DEBIAN_FRONTEND=noninteractive
RUN apt install -y python3 python3-pip expect curl gpg
RUN pip install boto3
WORKDIR /
RUN curl -sL https://repos.influxdata.com/influxdb.key | apt-key add -
RUN echo "deb https://repos.influxdata.com/ubuntu bionic stable" | tee /etc/apt/sources.list.d/influxdb.list
RUN apt update -y
RUN apt install -y influxdb
RUN rm -rf /var/cache/apt
ADD backup.sh /backup.sh
ADD public.pgp /public.pgp
RUN gpg --import /public.pgp
ADD trust.exp /trust.exp
RUN /usr/bin/expect /trust.exp
ADD upload.py /upload.py
ADD run.sh /run.sh
CMD [ "/usr/bin/bash", "/run.sh"]
