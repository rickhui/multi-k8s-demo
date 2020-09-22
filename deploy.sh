docker build -t rickhuihk/multi-client:latest -t rickhuihk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rickhuihk/multi-server:latest -t rickhuihk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rickhuihk/multi-worker:latest -t rickhuihk/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rickhuihk/multi-client:latest
docker push rickhuihk/multi-server:latest
docker push rickhuihk/multi-worker:latest
docker push rickhuihk/multi-client:$SHA
docker push rickhuihk/multi-server:$SHA
docker push rickhuihk/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rickhuihk/multi-server:$SHA
kubectl set image deployments/client-deployment client=rickhuihk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rickhuihk/multi-worker:$SHA