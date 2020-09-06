#!/bin/bash

docker build -t horadrik/multi-client:$GIT_HASH -f ./client/Dockerfile ./client
docker build -t horadrik/multi-server:$GIT_HASH -f ./server/Dockerfile ./server
docker build -t horadrik/multi-worker:$GIT_HASH -f ./worker/Dockerfile ./worker

docker push horadrik/multi-client:latest
docker push horadrik/multi-client:$GIT_HASH
docker push horadrik/multi-server:latest
docker push horadrik/multi-server:$GIT_HASH
docker push horadrik/multi-worker:latest
docker push horadrik/multi-worker:$GIT_HASH

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=horadrik/multi-client:$GIT_HASH
kubectl set image deployments/server-deployment server=horadrik/multi-server:$GIT_HASH
kubectl set image deployments/worker-deployment worker=horadrik/multi-worker:$GIT_HASH