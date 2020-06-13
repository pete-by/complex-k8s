#!/usr/bin/env bash

# Building images
docker build -t peteby/multi-client:latest -t peteby/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t peteby/multi-server:latest -t peteby/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t peteby/multi-worker:latest -t peteby/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Pushing to Dockerhub
docker push peteby/multi-client:latest
docker push peteby/multi-server:latest
docker push peteby/multi-worker:latest

docker push peteby/multi-client:$SHA
docker push peteby/multi-server:$SHA
docker push peteby/multi-worker:$SHA

# Apply kubernetes configurations
kubectl apply -f k8s

# Set version on images
kubectl set image deployments/client-deployment client=peteby/multi-client:$SHA
kubectl set image deployments/server-deployment server=peteby/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=peteby/multi-worker:$SHA
