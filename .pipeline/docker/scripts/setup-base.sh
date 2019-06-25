#!/usr/bin/env bash
set -e
echo "Start Time $0: $(date)"
start=$(date +%s)

# create build info
create_buildinfo(){
  echo "Build Date = $(date)" > /opt/"$(basename $0)"-builddate.$(date +'%y%m.%d.%H%M')
}

# user to run app so root user isn't used
create_users (){
    echo -e "\n\n\t\t creating app user.... \n\n"
    groupadd -r johndoe -g 10001
    useradd -u 10001 -r -g johndoe -m -d /opt/johndoe -s /sbin/nologin -c "John Doe User" johndoe
    # TODO: REview correct user permissions
    chmod -R 755 /opt/johndoe
}

# install required software
install_software(){
  echo -e "\n\n\t\t $1 installing... \n\n"
  apt-get install -qq -y "$1"
}

# # Generate a self signed certificate if we need it
generate_certs(){
  if [ ! -e "/etc/sample_app.crt" ] || [ ! -e "/etc/sample_app.key" ]; then
    echo  -e "\n\n\t\t  Generating self signed certificate.... \n\n ";
    openssl req -x509 -newkey rsa:4096 \
        -subj "/C=AU/ST=NSW/L=Sydney/O=IT/CN=localhost" \
        -keyout "/etc/sample_app.key" \
        -out "/etc/sample_app.crt" \
        -days 365 -nodes -sha256;
  fi

  update-ca-certificates -f
}

# install requirements
install_requirements(){
    cd /opt/product
    pip install -r requirements.txt
    cd -
}

# Clean up to reduce docker iamge size
clean_up(){
    echo -e "\n\n\t\t Cleaning up and locking down... \n\n"
    apt-get clean -qq -y
    apt-get autoclean -qq -y
    apt-get autoremove -qq -y
    rm -rf /var/lib/apt/lists/*
    rm -rf /tmp/*
    #lock down chmod to restrict use
    #find / -perm /6000 -type f -exec chmod a-s {} \; || true
    # Delete self
    rm "$0"
}


# update apt cache and upgrade
echo -e "\n\n\t\t update apt cache and upgrade...  \n\n"
apt-get update  -y -qq
apt-get upgrade -y -qq

create_buildinfo
install_software openssl
install_software ca-certificates
# Nano for debugging
install_software nano
install_requirements
create_users
generate_certs
clean_up

end=$(date +%s)
runtime=$((end-start))
echo -e "\nRuntime Seconds: " $runtime
echo "Runtime Minutes: " $((runtime/60))

echo "End Time $0: $(date)"
