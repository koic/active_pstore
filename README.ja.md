# ActivePStore

## DESCRIPTION

ActiveRecordに似たインターフェイスを持ったライブラリです。
データの保存にはpstoreを使います。

## FEATURES/PROBLEMS

* それなりに問題を持っています
* 安全面とか
* トランザクション
* 堅牢性
* データマイグレーション
* エンタープライズには向かないです
* こんなところ？

## SYNOPSIS

データの保存

```
class Artist < ActivePStore::Base
  def initialize(name)
    @name = name
  end

  attr_reader :name
end

randy_rhoads = Artist.new('Randy Rhoads')

randy_rhoads.save
```

検索系

```
Artist.find('388980778246cbcbfcbb7a8292f28c37') # 保存時にSecureRandom.hexの値を使ったActivePStore::Base#idを付与されています
Artist.where(name: 'Randy Rhoads')
Artist.all
Artist.first
Artist.last
```

範囲指定

```
Artist.where(birth_date: Date.new(1948, 12, 3)..Date.new(1956, 12, 6))
```

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
$ gem install
```

## LICENCE

The MIT Licence

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
