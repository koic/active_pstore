# Active PStore [![Build Status](https://travis-ci.org/koic/active_pstore.svg)](https://travis-ci.org/koic/active_pstore) [![Code Climate](https://codeclimate.com/github/koic/active_pstore/badges/gpa.svg)](https://codeclimate.com/github/koic/active_pstore) [![Test Coverage](https://codeclimate.com/github/koic/active_pstore/badges/coverage.svg)](https://codeclimate.com/github/koic/active_pstore/coverage) [![Gem Version](https://badge.fury.io/rb/active_pstore.svg)](http://badge.fury.io/rb/active_pstore)

[Active Record](https://github.com/rails/rails/tree/master/activerecord)に似たインターフェイスを持ったライブラリです。
データの保存には[pstore](http://docs.ruby-lang.org/ja/2.2.0/library/pstore.html)を使います。

## FEATURES/PROBLEMS

* それなりに問題を持っています
* トランザクションをサポートしてません (PStoreサポートレベルまで少しなんとかしたい)
* データマイグレーションをサポートしてません
* パフォーマンスへはかなりアマい実装になっています (いずれもう少しなんとかしたい)
* これらのことからエンタープライズ要件には向かないです

## SYNOPSIS

### クラス定義とインスタンスの生成

```ruby
require 'active_pstore'

class Artist < ActivePStore::Base
  def initialize(name)
    @name = name
  end

  attr_reader :name
end

randy_rhoads = Artist.new('Randy Rhoads')
```

### データの保存先のファイルパス指定

```ruby
Artist.establish_connection(database: '/path/to/file')
```

### インスタンスの保存

```ruby
randy_rhoads.save
```

saveメソッドの対象オブジェクトのクラス名がPStoreのキーになります。

```ruby
Artist.table_name # => 'Artist'
```

例えばPStoreをもちいて保存されたartistオブジェクトを取得してみます。

```ruby
database = PStore.new('/path/to/file')
database.transaction {|db| artist = db['Artist'] } # fetch instances of Artist class.
```

保存時に[SecureRandom.hex](http://docs.ruby-lang.org/ja/2.2.0/class/SecureRandom.html#S_HEX)の値を使ったActivePStore::Base#idが付与されます。

```ruby
> randy_rhoads.id # => nil 
> randy_rhoads.save
> randy_rhoads.id # => "0b84ece5d5be3bce3ee2101c1c4f6fda"
```

### 検索系

```ruby
Artist.all
Artist.first
Artist.last
Artist.find('388980778246cbcbfcbb7a8292f28c37')
Artist.where(name: 'Randy Rhoads')
```

範囲指定

```ruby
Artist.where(birth_date: Date.new(1948, 12, 3)..Date.new(1956, 12, 6))
```

続きは[テストコード](https://github.com/koic/active_pstore/tree/master/spec)をご参照ください。

## REQUIREMENTS

* no requirements

## INSTALL

Add these lines to your application's Gemfile:

```
gem 'active_pstore'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install active_pstore
```

And require it as:

```
require 'active_pstore'
```

## プレゼンテーション文書

* 誕生秘話 ... http://www.slideshare.net/koic/software-development-and-rubygems

## LICENCE

The MIT Licence

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
