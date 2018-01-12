#!/bin/bash

# change to the home directory
cd ~

# download the current tangle database
wget http://db.iota.partners/IOTA.partners-mainnetdb.tar.gz

# make a data directory for the database and unpack it
mkdir -p iri/mainnetdb
tar -xvf IOTA.partners-mainnetdb.tar.gz -C iri/mainnetdb

# run IRI with the data mounted into it
docker run -d \
    --net host \
    -p 14265:14265 \
    --name iri \
    -v $(pwd)/iri/mainnetdb:/iri/mainnetdb \
    iotaledger/iri

# run nelson to manage neighbors
docker run -d \
    --net host \
    -p 18600:18600 \
    --name nelson \
    romansemko/nelson.cli \
    -r localhost \
    -i 14265 \
    -u 14777 \
    -t 15777 \
    --neighbors "mainnet.deviota.com/16600 mainnet2.deviota.com/16600 mainnet3.deviota.com/16600 iotairi.tt-tec.net/16600"
