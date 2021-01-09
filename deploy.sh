docker build -t tkim0719/multi-client:latest -t tkim0719/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tkim0719/multi-server:latest -t tkim0719/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tkim0719/multi-worker:latest -t tkim0719/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tkim0719/multi-client:latest
docker push tkim0719/multii-server:latest
docker push tkim0719/multi-worker:latest

docker push tkim0719/multi-client:$SHA
docker push tkim0719/multi-server:$SHA
docker push tkim0719/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tkim0719/multi-server:$SHA
kubectl set image deployments/client-deployment client=tkim0719/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tkim0719/multi-worker:$SHA
