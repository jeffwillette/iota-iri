# IOTA - IRI

This is a shell script that was written to be able to launch a full IOTA IRI public node
with a single command. This script requires docker to be installed 4GB ram is the smallest
amount of memory I have been successful on. (2GB ram fails and 3GB is not available on my
cloud provider)

### Neighbors 

This setup uses [Nelson](https://github.com/SemkoDev/nelson.cli) to manage neighbors

### Storage

The full tangle database is downloaded from`iota.partners` and used as a jumping point
to start from which makes the process of syncing faster

### Usage

1. make sure you have [docker](https://docs.docker.com/engine/installation/) installed on
your machine 

2. clone or copy the `iota.sh` file from this repository onto your machine, make sure it
   is has executable permissions

3. run the script...

```bash
$ iota.sh
```

4. after starting, make sure that you have both docker containers running.

```shell
$ docker ps
```

if there are two containers there named `iri`, and `nelson` then everything is probably
working as expected. Check a few times over the next few minutes to make sure that
everything is still running (if there are memory constraints on your machine, you will find out
and one of them will crash after a few minutes)

at this point your node is not synced. It still needs a few hours in order to fully sync
with the tangle by talking with its neighbors. 

### Checking for sync

If you try to connect a wallet to your server, it will fail until there is a full sync.
You can check for a full sync by executing the following command...

```bash
curl http://localhost:14265 \
  -X POST \
  -H 'Content-Type: application/json' \
  -H 'X-IOTA-API-Version: 1' \
  -d '{"command": "getNodeInfo"}' \
  python -m json.tool
```

It should output something like this

```json
{
    "appName": "IRI",
    "appVersion": "1.0.8.nu",
    "duration": 1,
    "jreAvailableProcessors": 4,
    "jreFreeMemory": 91707424,
    "jreMaxMemory": 1908932608,
    "jreTotalMemory": 122683392,
    "latestMilestone": "VBVEUQYE99LFWHDZRFKTGFHYGDFEAMAEBGUBTTJRFKHCFBRTXFAJQ9XIUEZQCJOQTZNOOHKUQIKOY9999",
    "latestMilestoneIndex": 107,
    "latestSolidSubtangleMilestone": "VBVEUQYE99LFWHDZRFKTGFHYGDFEAMAEBGUBTTJRFKHCFBRTXFAJQ9XIUEZQCJOQTZNOOHKUQIKOY9999",
    "latestSolidSubtangleMilestoneIndex": 107,
    "neighbors": 2,
    "packetsQueueSize": 0,
    "time": 1477037811737,
    "tips": 3,
    "transactionsToRequest": 0
}
```

when `latestSolidSubtangleMilestoneIndex` and `latestMilestoneIndex` are the same number,
your server has been fully synced. The numbers will probably be much higher than what is
posted above. The full sync will probably take quite a while, so as long as the machines
are running, give it its time (maybe the better part of a day) 
