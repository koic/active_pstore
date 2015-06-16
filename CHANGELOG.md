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
