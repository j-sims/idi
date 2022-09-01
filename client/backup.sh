WORKDIR=/working
TS=`date "+%Y%m%d-%H%M%S"`
[[ ! -d $WORKDIR ]] && mkdir -p $WORKDIR
[[ `find $WORKDIR -maxdepth 0 -empty` == "" ]] && rm -f $WORKDIR/*
/usr/bin/influxd backup -portable -database isi_data_insights -host influxdb:8088 $WORKDIR && \
tar cf /backups/backup-$TS.tar $WORKDIR && \
gpg --output /backups/latestbackup.gpg --encrypt --recipient "Dell UDS CAE" /backups/backup-$TS.tar && \
echo success