## 0.3.1

Bug fix:

* `ActivePStore::Base.find_by(conditions)`

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
