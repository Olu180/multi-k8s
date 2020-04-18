docker build -t olu180/multi-client:latest -t olu180/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t olu180/multi-server:latest -t olu180/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t olu180/multi-worker:latest -t olu180/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push olu180/multi-client:latest
docker push olu180/multi-server:latest
docker push olu180/multi-worker:latest

docker push olu180/multi-client:$SHA
docker push olu180/multi-server:$SHA
docker push olu180/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=olu180/multi-server:$SHA
kubectl set image deployments/client-deployment client=olu180/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=olu180/multi-worker:$SHA