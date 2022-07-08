#!/bin/bash
LOGFILE="isidatainsights.log"
usage() {
    echo "$0 [clean|build|start|stop|status|upload|exportdb]"
    exit 0
}

die () {
    echo $1
    tail -n 10 $LOGFILE
    exit 1
}

getclusters() {
    [[ -f clusters.toml ]] && die "clusters.toml exists, aborting" && touch clusters.toml
    PROMPT="true"
    while $PROMPT == "true"
    do
        echo ""
        echo "Enter then cluster DNS name or IP address"
        printf "%s" "Cluster: "
        read CLUSTER
        echo "Enter the username"
        printf "%s" "Username: "
        read USER
        echo "Enter the password"
        printf "%s" "Password: "
        read PASSWORD
        echo ""
        echo "----------------------------------------------------------------"
        printf "Cluster Name (or IP): %s\n" "$CLUSTER"
        printf "Username: %s\n" "$USER"
        printf "Password: %s\n" "$PASSWORD"
        echo ""
        printf "%s" "Is this correct? (y/n) : "
        read VALID
        if [[ $VALID == "y" ]]
        then
            echo "Writing"
            echo "[[cluster]]" >> ./clusters.toml
            echo "hostname = \"$CLUSTER\"" >> ./clusters.toml
            echo "username = \"$USER\"" >> ./clusters.toml
            echo "password = \"$PASSWORD\"" >> ./clusters.toml
        fi
        echo ""
        printf "%s" "Add another cluster? (y/n) :"
        read ANOTHER
        [[ "$ANOTHER" == "y" ]] && PROMPT="true" || PROMPT="false"
    done
}

start () {
    echo "Starting..."
    docker-compose up -d | tee -a $LOGFILE && \
    echo "started!"
    [[ ! -f .firstrun ]] && \
    echo "" && \
    echo "Disable the firewall on your Docker Host or add a rule to allow access to Port 3000" && \
    echo "" && \
    echo "Point your browser to one of the following URLs:" && \
    ip a | grep inet | grep -v inet6 | awk '{print$2}' |awk -F\/ '{print$1}' |  while read IP; do echo "http://$IP:3000/dashboards"; done && \
    #ifconfig | grep inet | grep -v inet6 | grep -v 127.0.0.1 | awk '{print$2}' | while read IP; do echo "http://$IP"; done
    echo "" && \
    echo "First Time Login: " && \
    echo "username: admin" && \
    echo "password: admin" && \
    touch .firstrun
}

[[ $1 == "" ]] && usage

case $1 in
    clean)
        echo "This process will DELETE the InfluxDB removing all stats and starting clean."
        echo ""
        echo "To confirm you intend to REMOVE EVERYTHING in the database please type DELETE at the prompt."
        echo ""
        printf "%s" "Prompt: "
        read ACTION
        if [[ "$ACTION" == "DELETE" ]]
        then
            docker-compose down >$LOGFILE 2>&1
            rm -rf backups/*  >$LOGFILE 2>&1
            rm -rf influxdb/data/*  >$LOGFILE 2>&1
            rm -rf clusters.toml  >$LOGFILE 2>&1
            docker images | grep $(basename `pwd`) | awk '{print$3}' | xargs docker rmi >$LOGFILE 2>&1
            docker rmi golang >$LOGFILE 2>&1
            docker rmi grafana/grafana-oss >$LOGFILE 2>&1
            docker rmi influxdb:1.8 >$LOGFILE 2>&1
            docker rmi isidatainsights-client >$LOGFILE 2>&1
            rm -f .firstrun
            rm -f $LOGFILE
            echo "Cleanup Complete"
        fi
            ;;
    build)
        echo "starting container build, may take a few minutes..."
        docker-compose build >$LOGFILE 2>&1 && \
        docker-compose pull  >$LOGFILE 2>&1 && \
        cd client && \
        docker build -t isidatainsights-client . >$LOGFILE 2>&1 && \
        cd .. && \
        echo "Completed building containers..." && \
        getclusters && \
        start || die "Error, checking logs"
        ;;

    start)
        start
        ;;
    stop)
        docker-compose down | tee -a $LOGFILE;;
    status)
        docker-compose ps | tee -a $LOGFILE;;
    exportdb)
        echo "exportdb"
        docker run --rm -ti --network isidatainsights -v `pwd`/backups:/backups isidatainsights-client;;
    upload)
        echo "upload"
        docker run --rm -ti --network isidatainsights -e UPLOAD=true -v `pwd`/backups:/backups isidatainsights-client;;
    *)
        usage;;
esac
