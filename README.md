# sample-app
Sample Flask App to be deployed to AWS

A separate ruby repo will run .pipeline/package_app.sh to packer the app to be deployed with docker


# Test locally

```bash
python3 -m venv venv
. venv/bin/activate
pip3 install -r requirements.txt
export FLASK_APP=hello_flask.py
flask run --host=0.0.0.0
```

Create test director 

`mkdir  /opt/agent-working-dir`

Create  /opt/agent-working-dir/rebuild.sh to be used for debug and testing

```
↳ cat rebuild.sh 
rm -rf docker product
docker image rm --force sample-app:1 || echo "No containers"
docker rm -vf $(docker ps -a -q) || echo  "No images"
git clone git@github.com:MarcusMaximus/sample-app.git product
./product/.pipeline/package_app.sh
cd docker
docker build -t 'sample-app:1' .
# Debug the docker container
# docker run --entrypoint 'env' -p"5000:5000" -it sample-app:1 bash
# run the container 
docker run -p"5000:5000" -it sample-app:1
```

Run ./rebuild.sh from the working directory to clean the directory and rebuild from repo

Test the app via
http://localhost:5000/hello
http://localhost:5000/health
http://localhost:5000/