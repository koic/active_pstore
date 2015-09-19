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

### データの保存先のファイルパス指定

```ruby
require 'active_pstore'

ActivePStore::Base.establish_connection(database: '/path/to/file')
```

### クラス定義

```ruby
class Artist < ActivePStore::Base
  attr_accessor :name
end
```

### インスタンスの生成

```ruby
randy_rhoads = Artist.new(name: 'Randy Rhoads')
```

や

```ruby
randy_rhoads = Artist.new {|a|
  a.name = 'Randy Rhoads'
}
```

`ActivePStore::Base.new` メソッドと別名として `ActivePStore::Base.build` を使うこともできます。

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

### ID

保存時に[SecureRandom.hex](http://docs.ruby-lang.org/ja/2.2.0/class/SecureRandom.html#S_HEX)の値を使ったActivePStore::Base#idが付与されます。

```ruby
randy_rhoads = Artist.new(name: 'Randy Rhoads')
randy_rhoads.id # => nil

randy_rhoads.save
randy_rhoads.id # => "0b84ece5d5be3bce3ee2101c1c4f6fda"
```

### インスタンスの生成時に保存

```ruby
randy_rhoads = Artist.create(name: 'Randy Rhoads')
```

や

```ruby
randy_rhoads = Artist.create {|a|
  a.name = 'Randy Rhoads'
}
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

## Integration with Rails

Active PStore では以下のジェネレータを用意しています。

### Generate config file

以下の行をRailsアプリケーションで実行してください。

```
bundle exec rails g active_pstore:config
```

config/active_pstore.yml が生成されます。

config/database.yml をもちいて Active PStore が pstore を使った保存先の情報を指定します。

```
development:
  database: db/active_pstore_development.yml
```

### Generate model file

以下の行をRailsアプリケーションで実行してください。

```
bundle exec rails g active_pstore:model artist name associated_act instrument birth_date
```

app/models/artist.rb が生成されます。

```ruby
class Artist < ActivePStore::Base
  attr_accessor :name
  attr_accessor :associated_act
  attr_accessor :instrument
  attr_accessor :birth_date
end
```

## REQUIREMENTS

* [Active Model](https://github.com/rails/rails/tree/master/activemodel)

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Active PStore is released under the [MIT License](http://www.opensource.org/licenses/MIT).
