# Version 0.0.1
FROM uwinart/base:latest

MAINTAINER Yurii Khmelevskii <y@uwinart.com>

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 && \
  echo deb http://dl.hhvm.com/debian wheezy main | tee /etc/apt/sources.list.d/hhvm.list && \
  apt-get -q update && \
  apt-get install -yq hhvm hhvm-dev libpq-dev && \
  cd /usr/src && \
  git clone https://github.com/PocketRent/hhvm-pgsql && \
  cd hhvm-pgsql && \
  hphpize && \
  cmake . && \
  make && \
  apt-get clean

# hhvm.dynamic_extension_path = /path/to/hhvm/extensions
# hhvm.dynamic_extensions[pgsql] = pgsql.so

EXPOSE 9000

CMD ["hhvm", "--mode", "server"]
