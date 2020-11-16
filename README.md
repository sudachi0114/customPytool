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

## Link
* [Pythonでグローバルコマンドを含んだパッケージを作る](https://qiita.com/fetaro/items/bb0eb8292127b5d1e9a8)
