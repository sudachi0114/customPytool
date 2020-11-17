# Python で「カスタムコマンド」を作成する
`setuptools` を使えば、グローバルに使えるコマンド (python tool) を作成することができる。

## How:
( `/usr/local/bin/` など ) 標準で PATH が通っているディレクトリに実行ファイルを作ってくれる。

### 作り方:

以下のような設定ファイルを用意する。

```src/setup.py
import setuptools

if __name__ == "__main__":
    setuptools.setup(
        name="myapp",
        version="0.0.1",
        packages=setuptools.find_packages(),
        entry_points={
            "console_scripts":[
                "myapp = myapp.app:main",
            ],
        },
    )
```

配置は下記の通り。ポイントは2つ。

1. `myapp/` と `setup.py` が同じ階層にある。
2. `myapp/app.py` (実行対象のソースコード) と同じ階層に `__init__.py` を用意する。(touch するだけで良い)

```
./src
├── myapp
│   ├── __init__.py
│   └── app.py
└── setup.py
```

* **HELP:** `2` がないと以下のようなエラーが出ます。

```Error
$ myapp hoge
Traceback (most recent call last):
  File "/usr/local/bin/myapp", line 5, in <module>
    from myapp.app import main
ModuleNotFoundError: No module named 'myapp'
```


## Usage:

```sh
# cd src/
python setup.py sdist
pip install dist/myapp-0.0.1.tar.gz

# これでパッケージ本体 dist/myapp-0.0.1.tar.gz と、
# メタデータディレクトリ myapp.egg-info/ ができるます。
```

```
myapp hoge fuga
# then return ['/usr/local/bin/myapp', 'hoge', 'fuga']
```

### Usage of Docker:

```sh
bash build.sh
bash run.sh
```

#### Usage of Make:

```sh
# if you want to execute all process and check result:
make

# want get docker container's console
make console

# want build docker image 
make build

# want remove docker image named mypybin (this image)
make clean
```

`mypybin` という名前のイメージがある状態で、新たに同名のイメージをビルドすると `<none>:<none>` という名前のついたイメージができてしまうことがあります。
その場合は下記のようにして、一括削除をすることができます。

```
# -f (フィルタ) オプションを使い、イメージを抽出することができます。
docker images -f "dangling=true"

# 先の検索結果を使って一括削除
docker rmi $(docker images -f "dangling=true" -q)

# docker v1.25 以降では、<none> image 削除用のコマンドが用意されています:
# cf. https://docs.docker.com/engine/reference/commandline/image_prune/
docker image prune
```

## Link
* [Pythonでグローバルコマンドを含んだパッケージを作る](https://qiita.com/fetaro/items/bb0eb8292127b5d1e9a8)
* [Dockerで none なイメージを一括で削除するワンライナー](https://qiita.com/DQNEO/items/e3a03a14beb616630032)
* [docker image prune](https://docs.docker.com/engine/reference/commandline/image_prune/)
* [Dockerに<none>:<none>なイメージが生まれてくる理由](https://suin.io/540)
