FROM centos:7.3.1611

WORKDIR /root

# install git
RUN yum install -y git

# install python
RUN yum -y groupinstall "Development Tools"
RUN yum install -y gcc libffi-devel python-devel openssl-devel
RUN curl -O https://www.python.org/ftp/python/2.7.5/Python-2.7.5.tgz && \
    tar xzvf Python-2.7.5.tgz && \
    cd Python-2.7.5 && \
    ./configure --with-threads && \
    make && \
    make install


# install ansible
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python
RUN pip install paramiko==2.0.2 --upgrade
RUN pip install pywinrm==0.1.1 --upgrade
RUN pip install Jinja2==2.8 --upgrade
RUN pip install PyYAML==3.12 --upgrade
RUN pip install setuptools==28.6.1 --upgrade
RUN pip install pycrypto==2.6.1 --upgrade
RUN pip install ansible-lint --upgrade
RUN git clone https://github.com/ansible/ansible.git Ansible
RUN cd ~/Ansible && \
    git checkout -b v2.0.0.1-1  refs/tags/v2.0.0.1-1 && \
    git submodule update --init --recursive && \
    echo "source Ansible/hacking/env-setup > /dev/null 2>&1" >> /etc/profile.d/shift_ware.sh && \
    sed -e "s/rm -r /rm -rf /g" ./hacking/env-setup -i && \
    source ./hacking/env-setup

# install ruby
RUN yum -y install zlib zlib-devel openssl-devel sqlite-devel gcc-c++ glibc-headers libyaml-devel readline readline-devel make libffi-devel git bzip2
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
ENV PATH $PATH:/root/.rbenv/bin:/root/.rbenv/shims
RUN rbenv install 2.3.0
RUN rbenv rehash
RUN rbenv global 2.3.0

# install serverspec(2018/2/7最新化)
RUN gem install serverspec -v 2.41.3
RUN gem install activesupport -v 5.1.4
RUN gem install winrm -v 1.8.0
RUN gem install httpclient -v 2.8.3
RUN gem install pry

# enable ssh
RUN yum -y install openssh-server
RUN ssh-keygen -A 
RUN echo password | passwd --stdin root

# 開発環境
RUN git clone https://github.com/ko-he-/my_neovim && \
    cd my_neovim && \
    ./install.sh

CMD ["/usr/sbin/sshd", "-D"]
