# Ceron解析 _(ceron-analyze)_

[![Travis](https://img.shields.io/travis/u6k/ceron-analyze.svg)](https://travis-ci.org/u6k/ceron-analyze) [![license](https://img.shields.io/github/license/u6k/ceron-analyze.svg)](https://github.com/u6k/ceron-analyze/blob/master/LICENSE) [![GitHub release](https://img.shields.io/github/release/u6k/ceron-analyze.svg)](https://github.com/u6k/ceron-analyze/releases) [![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme) [![WebSite](https://img.shields.io/website-up-down-green-red/https/shields.io.svg?label=u6k.Redmine)](https://redmine.u6k.me/projects/ceron-analyze)

> "ceron.jp"を解析する

__Table of Contents__

- [Install](#Install)
- [Usage](#Usage)
- [Other](#Other)
- [API](#API)
- [Maintainer](#Maintainer)
- [Contributing](#Contributing)
- [License](#License)

## Install

Rubyを使用します。

```
$ ruby --version
ruby 2.6.0p0 (2018-12-25 revision 66547) [x86_64-linux]
```

`Gemfile`に次を追加して、`bundle install`でインストールします。

```
gem 'crawline', :git => 'https://github.com/u6k/crawline.git'
gem 'ceron_analyze', :git => 'https://github.com/u6k/ceron-analyze.git'
```

## Usage

```
$ ceron-analyze help
Commands:
  ceron-analyze crawl           # Crawl ceron.jp
  ceron-analyze help [COMMAND]  # Describe available commands or one specific command
  ceron-analyze version         # Display version
```

## Other

最新の情報は、 [Wiki - ceron-analyze - u6k.Redmine](https://redmine.u6k.me/projects/ceron-analyze/wiki) を参照してください。

- [ビルド手順](https://redmine.u6k.me/projects/ceron-analyze/wiki/%E3%83%93%E3%83%AB%E3%83%89%E6%89%8B%E9%A0%86)
- [リリース手順](https://redmine.u6k.me/projects/ceron-analyze/wiki/%E3%83%AA%E3%83%AA%E3%83%BC%E3%82%B9%E6%89%8B%E9%A0%86)

## API

[APIリファレンス](https://u6k.github.io/ceron-analyze/) を参照してください。

## Maintainer

- u6k
    - [Twitter](https://twitter.com/u6k_yu1)
    - [GitHub](https://github.com/u6k)
    - [Blog](https://blog.u6k.me/)

## Contributing

当プロジェクトに興味を持っていただき、ありがとうございます。[新しいチケットを起票](https://redmine.u6k.me/projects/ceron-analyze/issues/new)していただくか、プルリクエストをサブミットしていただけると幸いです。

当プロジェクトは、[Contributor Covenant](https://www.contributor-covenant.org/version/1/4/code-of-conduct)に準拠します。

## License

[MIT License](https://github.com/u6k/ceron-analyze/blob/master/LICENSE)
