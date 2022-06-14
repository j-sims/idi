# Build It
docker build -t gostats .

# Run It - Specify env variables for db and cluster
docker run --rm -ti -d -e DBHOST=172.16.10.1 -e DBPORT=8086 -e DBNAME=isi_data_insights -e CLUSTER=172.16.10.10 -e CUSER=root -e CPASS=a --name gostats gostats
9acb480ca75f114261f100acc68500e9b12734f6a411d324f63b0d403c8a95b8

# Check logs to see it working
root@macbook:/docker/gostats# docker logs -f gostats
2022-04-05T15:12:29Z main.go:103 NOTICE Starting gostats version 0.06
2022-04-05T15:12:29Z main.go:107 INFO Successfully read config file
2022-04-05T15:12:29Z main.go:110 INFO Parsing stat groups and stats
2022-04-05T15:12:29Z main.go:123 INFO spawning collection loop for cluster 172.16.10.10
2022-04-05T15:12:29Z main.go:218 INFO No authentication type defined for cluster 172.16.10.10, defaulting to session
2022-04-05T15:12:29Z main.go:240 INFO Connected to cluster demo, version Isilon OneFS 9.3.0.0 (Release, Build B_9_3_0_001(RELEASE), 2021-09-12 17:23:27, 0x903005000000001)
2022-04-05T15:12:29Z main.go:255 INFO Calculating stat refresh times for cluster demo
2022-04-05T15:12:37Z main.go:273 INFO Starting stat collection loop for cluster demo
2022-04-05T15:12:37Z isilon_api.go:245 INFO fetching 97 stats from cluster demo
2022-04-05T15:12:38Z isilon_api.go:245 INFO fetching 12 stats from cluster demo
2022-04-05T15:12:38Z isilon_api.go:245 INFO fetching 7 stats from cluster demo
2022-04-05T15:12:42Z isilon_api.go:245 INFO fetching 97 stats from cluster demo
2022-04-05T15:12:47Z isilon_api.go:245 INFO fetching 12 stats from cluster demo
2022-04-05T15:12:48Z isilon_api.go:245 INFO fetching 97 stats from cluster demo
