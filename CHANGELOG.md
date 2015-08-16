## 0.4.6

* [ActivePStore::Collection#count accepts args](https://github.com/koic/active_pstore/commit/e93af5956e42299a04684d6eaec1d47cfbfcd498)
* [add like ActiveRecord::ModelSchema.table_name method](https://github.com/koic/active_pstore/commit/b3cf8b27cfb262d421f141852c79dd1854cd508a)

## 0.4.5

* [add minimum method](https://github.com/koic/active_pstore/tree/9cb90a041fad051415739c3791e65fe23064bd45)
* [add maximum method](https://github.com/koic/active_pstore/tree/1e532b416576b42247db48fa9c34155a8efb86ff)

## 0.4.4

* [add ActivePStore::Base.ids method](https://github.com/koic/active_pstore/commit/6fca3160351a0485455da9c18713cf26095c2078)
* [add ActivePStore::Collection#ids method](https://github.com/koic/active_pstore/commit/2becc3c96997388484e90c45f3acb5e91dbbfe0c)

## 0.4.3

* [add ActivePStore#update method](https://github.com/koic/active_pstore/commit/464f7f38e1c9d05d8fc5a6ce1e4cfce8fc0029f7)

## 0.4.2

* [add dynamic finder method](https://github.com/koic/active_pstore/commit/07b2dcb664022b283782cf12c9725e14e591489d)

## 0.4.1

* [identify ActivePStore::Collection object](https://github.com/koic/active_pstore/commit/0dc9b7e1a2054ecfaaf11f0cdbd9bae20251f6ee)

## 0.4.0

* rename this library (active-pstore -> active_pstore). change to recommended gem name.

## 0.3.1

Bug fix:

* [`ActivePStore::Base.find_by(conditions)`](https://github.com/koic/active_pstore/commit/8cf9d41c5434fe8f6f60e98b20e2e1ec07a05d6a)

## 0.3.0

introduce ActivePStore::Collection. (inspire by ActiveRecord::Relation)

describable codes:

* `ActivePStore::Base.where(conditions).update_all(updates)`
* `ActivePStore::Base.where(conditions).destroy_all`
* `ActivePStore::Base.where(conditions).count`
* `ActivePStore::Base.where(conditions).empty?`

## 0.2.0

* identify an object by ActivePStore::Base#id.
* add several finder methods.
