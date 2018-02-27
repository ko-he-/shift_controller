# ansible_LXD

# 環境
Ansible実行ホスト：
Ubuntu 16.04


# 使い方



- 初期構築時
ansible-playbook -i init_hosts site.yaml

- ターゲット作成
 ansible-playbook -i hosts site.yaml --extra-vars '{ "targets": [{"base": "base-centos6", "name": "test01"}, {"base": "base-centos7", "name": "test02"}]}'
