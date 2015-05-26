# ActivePStore

## DESCRIPTION

This library has ActiveRecord like interface. Use pstore to store data.

## FEATURES/PROBLEMS

* Oh so many problems…
* Safety...
* Transaction
* Robustness
* Data Migration
* Not solving the root cause...
* Just to name a few

## SYNOPSIS

save

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

find series

```
Artist.find('388980778246cbcbfcbb7a8292f28c37') # ActivePStore::Base#id is an SecureRandom.hex value
Artist.where(name: 'Randy Rhoads')
Artist.all
Artist.first
Artist.last
```

between

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
