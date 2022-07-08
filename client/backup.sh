WORKDIR=/working
TS=`date "+%Y%m%d-%H%M%S"`
[[ ! -d $WORKDIR ]] && mkdir -p $WORKDIR
[[ `find $WORKDIR -maxdepth 0 -empty` == "" ]] && rm -f $WORKDIR/*
/usr/bin/influxd backup -database isi_data_insights -host influxdb:8088 $WORKDIR && \
tar cf $WORKDIR/backup-$TS.tar /backups && \
cp $WORKDIR/backup-$TS.tar /backups && \
gpg --output /backups/backups.gpg --encrypt --recipient "Dell UDS CAE" $WORKDIR/backup-$TS.tar && \
[[ `find $WORKDIR -maxdepth 0 -empty` == "" ]] && rm -f $WORKDIR/*
