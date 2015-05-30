# ActivePStore

## DESCRIPTION

ActiveRecordに似たインターフェイスを持ったライブラリです。
データの保存には[pstore](http://docs.ruby-lang.org/ja/2.2.0/library/pstore.html)を使います。

## FEATURES/PROBLEMS

* それなりに問題を持っています
* トランザクションをサポートしてません
* データマイグレーションをサポートしてません
* パフォーマンス (特に実装面とか)
* これらのことからエンタープライズ要件には向かないです

## SYNOPSIS

### クラス定義とインスタンスの生成

```
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

```
Artist.establish_connection(database: '/path/to/file')
```

### インスタンスの保存

```
randy_rhoads.save
```

saveメソッドの対象オブジェクトのクラス名がPStoreのキーになります。

```
database = PStore.new('/path/to/file')
database.transaction {|db| artist = db['Artist'] } # fetch instances of Artist class.
```

保存時にSecureRandom.hexの値を使ったActivePStore::Base#idが付与されます。

```
> randy_rhoads.id # => nil 
> randy_rhoads.save
> randy_rhoads.id # => "0b84ece5d5be3bce3ee2101c1c4f6fda"
```

### 検索系

```
Artist.all
Artist.first
Artist.last
Artist.find('388980778246cbcbfcbb7a8292f28c37')
Artist.where(name: 'Randy Rhoads')
```

範囲指定

```
Artist.where(birth_date: Date.new(1948, 12, 3)..Date.new(1956, 12, 6))
```

続きはテストコードをご参照ください。

## REQUIREMENTS

* no requirements

## INSTALL

Add these lines to your application's Gemfile:

```
gem 'active-pstore'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install active-pstore
```

## LICENCE

The MIT Licence

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
