[[ `find /backups -maxdepth 0 -empty` == "" ]] && rm -f /backups/* || echo "No Cleanup Required"
/usr/bin/influxd backup -database isi_data_insights -host influxdb:8088 /backups
tar cf /backup.tar /backups
gpg --output /backups.gpg --encrypt --recipient "Dell UDS CAE" /backup.tar
[[ `find /backups -maxdepth 0 -empty` == "" ]] && rm -f /backups/* || echo "No Cleanup Required"
mv /backups.gpg /backups
