more details about build:
https://github.com/SAP-samples/datahub-integration-examples/blob/main/GitWorkflow/vscode-app/Readme.md

# build new image
docker build --tag kanyin/vsc-app:4.23.1 .

# run locally and test this new version
docker run -p 3000:3000 kanyin/vsc-app:4.23.1

# add latest tag
docker tag kanyin/vsc-app:4.23.1 kanyin/vsc-app:latest

# push to dockerhub
docker push kanyin/vsc-app:latest

# create solution for sap di
cd DI_Solution/solution;zip -r ../vscode_4.23.1.zip *
