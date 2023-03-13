
# build new image
docker build --tag kanyin/vsc-app:4.10.0 .

# run locally
docker run -p 3000:3000 kanyin/vsc-app:4.10.0