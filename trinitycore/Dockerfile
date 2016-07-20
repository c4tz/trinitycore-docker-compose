FROM debian:latest

ARG root_pw

# install programs
RUN apt-get update \
    && apt-get install -y \
		cmake \
		g++ \
		gcc \
		git \
		jq \
		libboost-filesystem-dev \
		libboost-dev \
		libboost-program-options-dev \
		libboost-iostreams-dev \
		libboost-system-dev \
		libboost-thread-dev \
		libbz2-dev \
		libmysqlclient-dev \
		libncurses-dev \
		libreadline-dev \
		libssl-dev \	
		make \
		mysql-client \
		netcat \
		nano \
		p7zip \
		wget

# add user + scripts
RUN useradd -ms /bin/bash wow
COPY conf/*.sh /home/wow/server/bin/
RUN chmod +x /home/wow/server/bin/*.sh
RUN sed -i "s/##CHANGE##/${root_pw}/g" /home/wow/server/bin/startup.sh
RUN chown -R wow. /home/wow
USER wow

# download files
RUN git clone -b 6.x git://github.com/TrinityCore/TrinityCore.git ~/source;

# install trinitycore
RUN cd ~/source; \
	mkdir build; \
	cd build; \
	cmake ../ -DCMAKE_INSTALL_PREFIX=/home/wow/server -DCONF_DIR=/home/wow/server/etc -DTOOLS=1 -DWITH_WARNINGS=1; \
	make -j$(nproc) install;

# download DB scripts
RUN cd /home/wow/server/bin && wget -O output.7z $(wget https://api.github.com/repos/TrinityCore/TrinityCore/releases -q -O -| jq -r ".[] | .assets | .[] | .browser_download_url" | grep -m 1 'TDB6.') && 7zr e output.7z */*.sql && rm output.7z

WORKDIR /home/wow/server/bin/
CMD ["/home/wow/server/bin/startup.sh"]
#CMD ["bash"]
