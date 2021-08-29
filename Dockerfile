FROM node:14.16.1-slim

ENV USER=venombot

# install python and make
RUN apt-get update && \
	apt-get install -y python3 build-essential && \
	apt-get purge -y --auto-remove
	
# create venombot user
RUN groupadd -r ${USER} && \
	useradd --create-home --home /home/venombot -r -g ${USER} ${USER}
	
# set up volume and user
USER ${USER}
WORKDIR /home/venombot

COPY package*.json ./
RUN npm install
VOLUME [ "/home/venombot" ]

COPY . .

ENTRYPOINT [ "node", "index.js" ]
