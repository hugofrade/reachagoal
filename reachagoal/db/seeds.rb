# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


	Badge.create(icon: 'change', type_badge: 'change', symbol: 'fa-bicycle' )
	Badge.create(icon: 'surprise', type_badge: 'surprise', symbol: 'fa-tachometer' )
	Badge.create(icon: 'overcome', type_badge: 'overcome', symbol: 'fa-line-chart' )
	Badge.create(icon: 'partner', type_badge: 'partner', symbol: 'fa-users' )
	Category.create(name: 'Compras' )
	Category.create(name: 'Viagens' )