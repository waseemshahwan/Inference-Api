docker build -t inference-server .
docker run --detach -p 5000:5000 --gpus all inference-server