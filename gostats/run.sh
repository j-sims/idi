#! /bin/bash

# Files
CONFIG="/go/gostats/idic.toml"
CLUSTERS="/clusters.toml"


# Set LOGLEVEL
if [[ "$LOGLEVEL" = "" ]]
then
	LOGLEVEL=NOTICE
fi

cat /go/gostats/idic.toml.master > /go/gostats/idic.toml
cat /clusters.toml >> /go/gostats/idic.toml

# default log level [CRITICAL|ERROR|WARNING|NOTICE|INFO|DEBUG] (default NOTICE)
/go/gostats/gostats -loglevel $LOGLEVEL -logfile /dev/stdout
	
