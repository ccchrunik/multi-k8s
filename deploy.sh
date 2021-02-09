docker build -t yingchiaochen/multi-client:latest -t yingchiaochen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yingchiaochen/multi-server:latest -t yingchiaochen/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yingchiaochen/multi-worker:latest -t yingchiaochen/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yingchiaochen/multi-client:latest
docker push yingchiaochen/multi-server:latest
docker push yingchiaochen/multi-worker:latest

docker push yingchiaochen/multi-client:$SHA
docker push yingchiaochen/multi-server:$SHA
docker push yingchiaochen/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=yingchiaochen/multi-client:$SHA
kubectl set image deployments/server-deployment server=yingchiaochen/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=yingchiaochen/multi-worker:$SHA