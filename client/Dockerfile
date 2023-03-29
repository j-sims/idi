from ubuntu:22.04
RUN apt update -y
ARG DEBIAN_FRONTEND=noninteractive
RUN apt upgrade -y
RUN apt install -y python3 python3-pip expect curl gpg wget
RUN pip install boto3
WORKDIR /
RUN wget -q https://repos.influxdata.com/influxdata-archive_compat.key && \
echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null && \
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | tee /etc/apt/sources.list.d/influxdata.list && \
apt update
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
