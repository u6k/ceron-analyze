# ceron-analyze

![Badge Status](https://ci-as-a-service)

現在、流行している記事を把握するため、Ceronをキャッシュ・分析します。

## Description

記事の価値を、流行を評価基準とするならば、流行は時間と共に変わってしまうので、日ごとに何が流行しているかを知らなければならない。そういったデータは、とりあえずCeronが良さそうなので、定期的にCeronのデータをキャッシュしたいです。

## Features

- Ceronの各カテゴリーをダウンロードして、S3ストレージに格納
- 格納されたデータを分析

## Requirement

- Docker

```
$ docker version
time="2017-04-23T15:28:26+09:00" level=info msg="Unable to use system certificate pool: crypto/x509: system root pool is not available on Windows"
Client:
 Version:      17.03.1-ce
 API version:  1.27
 Go version:   go1.7.5
 Git commit:   c6d412e
 Built:        Tue Mar 28 00:40:02 2017
 OS/Arch:      windows/amd64

Server:
 Version:      17.04.0-ce
 API version:  1.28 (minimum version 1.12)
 Go version:   go1.7.5
 Git commit:   4845c56
 Built:        Wed Apr  5 18:45:47 2017
 OS/Arch:      linux/amd64
 Experimental: false
```

## Usage

TODO

1. Usage
2. Usage
3. Usage

## Installation

### 開発環境を構築

開発用Dockerイメージを作成します。

```
$ docker build -t ceron-analyze-dev -f Dockerfile-dev .
```

Mavenプロジェクトを作成します。

```
$ docker run \
    --rm \
    -v $HOME/.m2:/root/.m2 \
    -v $(pwd):/var/my-app \
    ceron-analyze-dev mvn eclipse:eclipse
```

### ビルド

テスト実行し、jarファイルをパッケージングします。

```
$ docker run \
    --rm \
    -v $HOME/.m2:/root/.m2 \
    -v $(pwd):/var/my-app \
    ceron-analyze-dev
```

実行用Dockerイメージを作成します。

```
$ docker build -t u6kapps/ceron-analyze .
```

### 起動

```
$ docker run \
    -d \
    --name ceron-analyze \
    -p 8080:8080 \
    u6kapps/ceron-analyze
```

## Author

- [ceron-analyze - u6k.Redmine](https://redmine.u6k.me/projects/ceron-analyze)
- [u6k/ceron-analyze](https://github.com/u6k/ceron-analyze)
- [u6k.Blog](https://blog.u6k.me/)

## License

[MIT License](https://github.com/u6k/ceron-analyze/blob/master/LICENSE)
