# sample-app
Sample Flask App to be deployed to AWS

A separate ruby repo will run .pipeline/package_app.sh to packer the app to be deployed with docker


# Test locally

Create test director 
`mkdir /tmp/working-dir`

Create /tmp/working-dir/rebuild.sh to be used for debug and testing

```
↳ cat rebuild.sh 
rm -rf docker product
docker image rm --force test-app:1
git clone git@github.com:MarcusMaximus/sample-app.git product
./product/.pipeline/package_app.sh
cd docker
docker build -t 'test-py:1' .
# Debug the docker container
# docker run --entrypoint 'env' -p"5000:5000" -it test-py:1 bash
# run the container 
docker run -p"5000:5000" -it test-py:1
```

Run ./rebuild.sh from the working directory to clean the directory and rebuild from repo

Test the app via
http://localhost:5000/hello
http://localhost:5000/