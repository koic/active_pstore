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
