docker build -t easternts2021/multi-client:latest -t easternts2021/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t easternts2021/multi-server:latest -t easternts2021/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t easternts2021/multi-worker:latest -t easternts2021/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker
docker push easternts2021/multi-client
docker push easternts2021/multi-client:$SHA
docker push easternts2021/multi-server
docker push easternts2021/multi-server:$SHA
docker push easternts2021/multi-worker
docker push easternts2021/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=easternts2021/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=easternts2021/multi-worker:$SHA
kubectl set image deployments/client-deployment client=easternts2021/multi-client:$SHA