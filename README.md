# SHIFT ware開発環境
Ubuntu Server 16.04.3 LTS (Xenial Xerus)



## 開発用コンテナの構築

- コンテナ起動

```
# cd dev_server
# docker build -t dev_server .
# docker run -d --name dev_server dev_server
```
- SHIFT ware clone

```
# sh ../tool/ip_check.sh
-e lxd_server   172.17.0.3
-e dev_server   172.17.0.2

# ssh root@172.17.0.2 # root/password
# git clone https://github.com/SHIFT-ware/shift_ware
```

## ホストマシンへのLXDインストール

- hostへのlxdインストール

```
# cd playbook
# ansible-playbook -i "<host ip>," --user root --ask-pass init_lxd.yaml
```

## ターゲットマシン作成

- ターゲット用LXDコンテナ作成

```
# ansible-playbook -i "<host ip>," --user root --ask-pass --extra-vars '{ "targets": [{"base": "base-centos6", "name": "test01"}, {"base": "base-centos7", "name": "test02"}]}' create_target.yaml
```

## etc/hostsの更新

- LXDを名前解決できるようにetc/hostsを更新

```
# ansible-playbook --connection=local update_hosts.yaml --extra-vars '{ "host_ip": "<host ip>", "host_pass": "<host password>"}'
```

## テストの実行

- host_varsで指定されたテストケースを実行

```
# ansible-playbook --connection=local run_tests.yaml

```

- ターゲット、テストケースを指定して実行

```
# ansible-playbook --connection=local run_tests.yaml --extra-vars '{"shiftware_directory": "/root/shift_ware", "targets": {"centos6": "test01", "centos7": "test02"}, "test_cases": ["1-0001_Base-ID_01"]}'
```


## ターゲットの作成からテスト実行までまとめて実行

```
# ansible-playbook -i hosts site.yaml
```

