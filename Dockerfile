FROM parkayun/ubuntu-11.04
MAINTAINER Adam Sanchez <a.sanchez75@gmail.com>
RUN sudo apt-get update && sudo apt-get install -y irb libopenssl-ruby libreadline-ruby rdoc ruby ruby-dev wget unzip libmysqlclient-dev build-essential mysql-client
RUN wget -O /usr/local/src/fedena-v2.3-bundler-linux.zip http://projectfedena.org/download/fedena-bundle-linux && \
    sudo unzip /usr/local/src/fedena-v2.3-bundler-linux.zip -d /usr/local/src/
RUN cd /usr/local/src && \
    wget http://production.cf.rubygems.org/rubygems/rubygems-1.3.7.tgz && \
    tar xzvf rubygems-1.3.7.tgz && \
    cd rubygems-1.3.7 && \
    sudo ruby setup.rb && \
    sudo update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.8 1 && \
    sudo gem install mysql && \
    sudo gem install bundler
#RUN sudo gem install rake -v '0.8.7' && \
#    sudo gem install activesupport -v '2.3.5' && \
#    sudo gem install rack -v '1.0.1' && \
#    sudo gem install actionpack -v '2.3.5' && \
#    sudo gem install actionmailer -v '2.3.5' && \
#    sudo gem install activerecord -v '2.3.5' && \
#    sudo gem install activeresource -v '2.3.5' && \
#    sudo gem install declarative_authorization -v '0.5.1' && \
#    sudo gem install fattr -v '2.2.1'
RUN cd /usr/local/src/fedena-v2.3-bundle-linux && \
    sudo bundle install --local
ADD database.yml /usr/local/src/fedena-v2.3-bundler-linux/config/database.yml
RUN cd /usr/local/src/fedena-v2.3-bundler-linux && \
    sudo rake db:create && \
    sudo rake fedena:plugins:install_all && \
    sudo script/server
CMD [/bin/bash]
