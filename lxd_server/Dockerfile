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
    git checkout -b v2.4.3.0-1  refs/tags/v2.4.3.0-1 && \
    git submodule update --init --recursive && \
    echo "source Ansible/hacking/env-setup > /dev/null 2>&1" >> /etc/profile.d/shift_ware.sh && \
    sed -e "s/rm -r /rm -rf /g" ./hacking/env-setup -i && \
    source ./hacking/env-setup

# enable ssh
RUN yum -y install openssh-server && \
    ssh-keygen -A && \
    echo password | passwd --stdin root

# 開発環境
RUN git clone https://github.com/ko-he-/my_neovim && \
    cd my_neovim && \
    ./install.sh

# LXD Ansibleコード
COPY playbook playbook

CMD ["/usr/sbin/sshd", "-D"]
