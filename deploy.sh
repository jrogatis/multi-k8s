docker build -t jrogatis/multi-client:latest -t jrogatis/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jrogatis/multi-server:latest -t jrogatis/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jrogatis/multi-worker:latest -t jrogatis/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jrogatis/multi-client:latest
docker push jrogatis/multi-server:latest
docker push jrogatis/multi-worker:latest

docker push jrogatis/multi-client:$SHA
docker push jrogatis/multi-server:$SHA
docker push jrogatis/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jrogatis/multi-server:$SHA
kubectl set image deployments/client-deployment client=jrogatis/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jrogatis/multi-worker:$SHA