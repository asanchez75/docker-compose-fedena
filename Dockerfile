FROM debian:wheezy
MAINTAINER Adam Sanchez <a.sanchez75@gmail.com>

RUN apt-get update && apt-get install -y ruby1.8-full wget unzip libmysqlclient-dev build-essential mysql-client
RUN ls -l /usr/lib/ruby/

RUN wget -O /usr/local/src/fedena-v2.3-bundle-linux.zip http://projectfedena.org/download/fedena-bundle-linux && \
    unzip /usr/local/src/fedena-v2.3-bundle-linux.zip -d /usr/local/src/

COPY Rakefile /usr/local/src/fedena-v2.3-bundle-linux/Rakefile

COPY database.yml /usr/local/src/fedena-v2.3-bundle-linux/config/database.yml

RUN cd /usr/local/src && \
    wget http://production.cf.rubygems.org/rubygems/rubygems-1.3.7.tgz && \
    tar xzvf rubygems-1.3.7.tgz && \
    cd /usr/local/src/rubygems-1.3.7 && \
    ruby setup.rb && \
    update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.8 1

RUN gem install bundler && \
    gem install rake -v '0.8.7' && \
    gem install activesupport -v '2.3.5' && \
    gem install rack -v '1.0.1' && \
    gem install actionpack -v '2.3.5' && \
    gem install actionmailer -v '2.3.5' && \
    gem install activerecord -v '2.3.5' && \
    gem install activeresource -v '2.3.5' && \
    gem install declarative_authorization -v '0.5.1' && \
    gem install fattr -v '2.2.1' && \
    gem install i18n -v '0.4.2' && \
    gem install mysql -v '2.8.1' && \
    gem install rails -v '2.3.5' && \
    gem install session -v '3.1.0' && \
    gem install rush -v '0.6.8'

RUN cd /usr/local/src/fedena-v2.3-bundle-linux && \
    bundle install --local

WORKDIR  /usr/local/src/fedena-v2.3-bundle-linux/

EXPOSE 3000

RUN rake db:create && \
   rake fedena:plugins:install_all && script/server

CMD ["/bin/bash"]
