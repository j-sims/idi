#!/usr/bin/env python3
import os
from re import X
import sys
import threading
import boto3
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

import uuid
uid = str(uuid.uuid4())

session = boto3.session.Session()
class ProgressPercentage(object):
    def __init__(self, filename):
        """ Transfer progress percentage class """
        self._filename = filename
        self._size = float(os.path.getsize(filename))
        self._seen_so_far = 0
        self._lock = threading.Lock()
    def __call__(self, bytes_amount):
        with self._lock:
            self._seen_so_far += bytes_amount
            percentage = (self._seen_so_far / self._size) * 100
            sys.stdout.write(
                "\r%s  %s / %s  (%.2f%%)" % (
                    self._filename, self._seen_so_far, self._size,
                    percentage))
            sys.stdout.flush()

ukc_ecs_s3 = session.client(
    service_name='s3',
    # The following can be obtained from the UKCloud portal
    aws_access_key_id='131357224683004424@ecstestdrive.emc.com',
    # The following can be obtained from the UKCloud portal
    aws_secret_access_key='dXGCbe112pekfS0cARrrBEvTbppr78Tyal6VLsPr',
    # The endpoint will be either https://cas.frn00006.ukcloud.com
    # or https://cas.frn00006.ukcloud.com
    endpoint_url='https://object.ecstestdrive.com',
)

# Assign source file, bucket name and key name values to vars
source_file = sys.argv[1]
bucket_name = 'isidatainsights'
# key name can be any value, suggest filename
key_name = uid


# create bucket
ukc_ecs_s3.create_bucket(Bucket=bucket_name)

# Upload file
ukc_ecs_s3.upload_file(source_file, bucket_name, key_name, Callback=ProgressPercentage(source_file))
sys.stdout.write("\n")
sys.stdout.flush()
print(f"Key: {uid}")
os.remove(source_file)
