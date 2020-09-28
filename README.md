# Docker-Deluge-OpenVPN-Owncloud
###### A Realy secure Deluge Container for some really Private Linux ISO Downloads that are automaticly added to the owncloud.

## How to setup.


### Install Docker and docker-compose
If you have not already installed docker you have to install it.
```
curl -fsSL https://get.docker.com | sh
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

### Setup the containers
#### Clone the Repository
You have to clone the repository
```
git clone https://github.com/techtasie/Docker-Deluge-OpenVPN-Owncloud 
cd Docker-Deluge-OpenVPN-Owncloud
```

#### Configuring the nginx Reverse Proxy for the owncloud
Add your SSL Certs as a [bundle](https://cleantalk.org/help/ssl-ca-bundle):
```
mkdir certs
cd certs
cp /your/crt/bundle.crt ./cert.crt
cp /your/private/key.key ./cert.key
cd ..
```

**IMPORTANT:** Set your Domain name in the nginx config:</br>
Change ```example.com``` in ```owncloud_proxy/nginx.conf``` to your public Domain.

### Start the containers
Just run:
```
docker-compose up
```

### Configure Deluged
Access the Deluge container by surfing to ```your-local-ip-address:8112```</br>
The default password is: ```deluge```
Set the completed downloads folder to ```/completed``` because all files in this folder are automaticly added to the Folder Deluge from root user on the owncloud.

### Configure the owncloud
Acces the owncloud by surfing to ```your-domain.com```</br>
Setup as ```root``` user the user ```root```
now the folder Deluge will be in the files of root and you can share it with other users
