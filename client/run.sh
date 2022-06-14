bash /backup.sh && \
	echo "Backup Successful" && \
	python3 upload.py /backups/backups.gpg && \
	echo "Upload Successful"
