# Active PStore [![Build Status](https://travis-ci.org/koic/active_pstore.svg)](https://travis-ci.org/koic/active_pstore) [![Code Climate](https://codeclimate.com/github/koic/active_pstore/badges/gpa.svg)](https://codeclimate.com/github/koic/active_pstore) [![Test Coverage](https://codeclimate.com/github/koic/active_pstore/badges/coverage.svg)](https://codeclimate.com/github/koic/active_pstore/coverage) [![Gem Version](https://badge.fury.io/rb/active_pstore.svg)](http://badge.fury.io/rb/active_pstore)

This library has [Active Record](https://github.com/rails/rails/tree/master/activerecord) like interface. Use [pstore](http://docs.ruby-lang.org/en/2.2.0/PStore.html) to store data.

## FEATURES/PROBLEMS

* Oh so many problems...
* Transaction NOT supported (caused by implementation)
* Data Migration NOT supported
* Performance (caused by implementation)
* and Not solving the root cause for enterprise...

## SYNOPSIS

### class definition and instantiate

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

### specify data store path

```ruby
Artist.establish_connection(database: '/path/to/file')
```

### save

```ruby
randy_rhoads.save
```

database key is string of class name.

```ruby
database = PStore.new('/path/to/file')
database.transaction {|db| artist = db['Artist'] } # fetch instances of Artist class.
```

allocate value of ActivePStore::Base#id using [SecureRandom.hex](http://ruby-doc.org/stdlib-2.2.0/libdoc/securerandom//rdoc/SecureRandom.html#method-c-hex).

```ruby
> foo.id # => nil 
> randy_rhoads.save
> foo.id # => "0b84ece5d5be3bce3ee2101c1c4f6fda"
```

### find series

```ruby
Artist.all
Artist.first
Artist.last
Artist.find('388980778246cbcbfcbb7a8292f28c37') # ActivePStore::Base#id is an SecureRandom.hex value
Artist.where(name: 'Randy Rhoads')
```

Range

```ruby
Artist.where(birth_date: Date.new(1948, 12, 3)..Date.new(1956, 12, 6))
```

see [spec codes](https://github.com/koic/active_pstore/tree/master/spec) for more information.

## REQUIREMENTS

no requirements

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

## Presentation Document

* The making of a story (Japanese text) ... http://www.slideshare.net/koic/software-development-and-rubygems

## LICENCE

The MIT Licence

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
