FROM parkayun/ubuntu-11.04
MAINTAINER Adam Sanchez <a.sanchez75@gmail.com>
RUN sudo apt-get update && sudo apt-get install -y irb libopenssl-ruby libreadline-ruby rdoc ruby ruby-dev wget unzip libmysqlclient-dev build-essential mysql-client
RUN wget -O /usr/local/src/fedena-v2.3-bundle-linux.zip http://projectfedena.org/download/fedena-bundle-linux && \
    sudo unzip /usr/local/src/fedena-v2.3-bundle-linux.zip -d /usr/local/src/
RUN cd /usr/local/src && \
    wget http://production.cf.rubygems.org/rubygems/rubygems-1.3.7.tgz && \
    tar xzvf rubygems-1.3.7.tgz && \
    cd rubygems-1.3.7 && \
    sudo ruby setup.rb && \
    sudo update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.8 1 && \
    sudo gem install bundler
RUN sudo gem install rake -v '0.8.7' && \
    sudo gem install activesupport -v '2.3.5' && \
    sudo gem install rack -v '1.0.1' && \
    sudo gem install actionpack -v '2.3.5' && \
    sudo gem install actionmailer -v '2.3.5' && \
    sudo gem install activerecord -v '2.3.5' && \
    sudo gem install activeresource -v '2.3.5' && \
    sudo gem install declarative_authorization -v '0.5.1' && \
    sudo gem install fattr -v '2.2.1' && \
    sudo gem install i18n -v '0.4.2' && \
    sudo gem install mysql -v '2.8.1' && \
    sudo gem install rails -v '2.3.5' && \
    sudo gem install session -v '3.1.0' && \
    sudo gem install rush -v '0.6.8'
RUN cd /usr/local/src/fedena-v2.3-bundle-linux && \
    sudo bundle install --local
COPY database.yml /usr/local/src/fedena-v2.3-bundle-linux/config/database.yml

WORKDIR  /usr/local/src/fedena-v2.3-bundle-linux/

EXPOSE 3000

#RUN sudo rake db:create && \
#    sudo rake fedena:plugins:install_all && script/server

CMD ["/bin/bash"]
