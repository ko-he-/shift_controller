FROM centos:7.3.1611

WORKDIR /root

# install git
RUN yum install -y git

# install python
RUN yum -y groupinstall "Development Tools" && \
    yum install -y gcc libffi-devel python-devel openssl-devel && \
    curl -O https://www.python.org/ftp/python/2.7.5/Python-2.7.5.tgz && \
    tar xzvf Python-2.7.5.tgz && \
    cd Python-2.7.5 && \
    ./configure --with-threads && \
    make && \
    make install 


# install ansible
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python && \
    pip install paramiko==2.0.2 --upgrade && \
    pip install pywinrm==0.1.1 --upgrade && \
    pip install Jinja2==2.8 --upgrade && \
    pip install PyYAML==3.12 --upgrade && \
    pip install setuptools==28.6.1 --upgrade && \
    pip install pycrypto==2.6.1 --upgrade && \
    pip install ansible-lint --upgrade && \
    git clone https://github.com/ansible/ansible.git Ansible && \
    cd ~/Ansible && \
    git checkout -b v2.0.0.1-1  refs/tags/v2.0.0.1-1 && \
    git submodule update --init --recursive && \
    echo "source Ansible/hacking/env-setup > /dev/null 2>&1" >> /etc/profile.d/shift_ware.sh && \
    sed -e "s/rm -r /rm -rf /g" ./hacking/env-setup -i && \
    source ./hacking/env-setup

# install ruby
RUN yum -y install zlib zlib-devel openssl-devel sqlite-devel gcc-c++ glibc-headers libyaml-devel readline readline-devel make libffi-devel git bzip2 && \
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv && \
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
ENV PATH $PATH:/root/.rbenv/bin:/root/.rbenv/shims
RUN rbenv install 2.3.0 && \
    rbenv rehash && \
    rbenv global 2.3.0

# install serverspec(2018/2/7最新化)
RUN gem install serverspec -v 2.41.3 && \
    gem install activesupport -v 5.1.4 && \
    gem install winrm -v 1.8.0 && \
    gem install httpclient -v 2.8.3 && \
    gem install pry

# enable ssh
RUN yum -y install openssh-server && \
    ssh-keygen -A && \
    echo password | passwd --stdin root

# 開発環境
RUN git clone https://github.com/ko-he-/my_neovim && \
    cd my_neovim && \
    ./install.sh

# 日本語化	
RUN yum reinstall -y glibc-common && yum clean all && \
    localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8


# bashrc
RUN export PATH=$PATH:/root/.rbenv/bin:/root/.rbenv/shims >> .bashrc && \
    export LANG=ja_JP.UTF-8 && \
    export LANGUAGE=ja_JP:ja && \
    export LC_ALL ja_JP.UTF-8


CMD ["/usr/sbin/sshd", "-D"]
