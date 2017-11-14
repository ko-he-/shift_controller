FROM centos:7.3.1611

WORKDIR /root

# install git
RUN yum install -y git

# install ansible
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python
RUN yum install -y gcc libffi-devel python-devel openssl-devel
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
    echo "source Ansible/hacking/env-setup > /dev/null 2>&1" >> ~/.bash_profile && \
    sed -e "s/rm -r /rm -rf /g" ./hacking/env-setup -i && \
    source ./hacking/env-setup

# install ruby
RUN yum -y install zlib zlib-devel openssl-devel sqlite-devel gcc-c++ glibc-headers libyaml-devel readline readline-devel make libffi-devel git bzip2
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo "export PATH=\$PATH:\$HOME/.rbenv/bin:\$HOME/.rbenv/shims" >> ~/.bash_profile
RUN source ~/.bash_profile && rbenv install 2.3.0
RUN source ~/.bash_profile && rbenv rehash
RUN source ~/.bash_profile && rbenv global 2.3.0

# install serverspec
RUN source ~/.bash_profile && gem install serverspec -v 2.37.0
RUN source ~/.bash_profile && gem install activesupport -v 5.0.0.1
RUN source ~/.bash_profile && gem install winrm -v 1.8.0
RUN source ~/.bash_profile && gem install httpclient -v 2.8.2.4
RUN source ~/.bash_profile && gem install pry

# enable ssh
RUN yum -y install openssh-server
RUN ssh-keygen -A 
RUN echo password | passwd --stdin root

CMD ["/usr/sbin/sshd", "-D"]

