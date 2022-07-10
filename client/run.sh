bash /backup.sh && \
	echo "Backup Successful" && \
	if [[ "$UPLOAD" == "true" ]]; then
	python3 upload.py /backups/latestbackup.gpg && \
	echo "Upload Successful"
	else
	rm /backups/backups.gpg
	fi
