# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


admin = User.new({username: 'Admin', email: 'admin@dmsti.es'})
admin.password='ADMIN1234'
admin.password_confirmation='ADMIN1234'
admin.rol = User.roles[:super_admin]

admin.save!

resultado = admin.save!
puts "Created and linked administrator user: '#{admin.username}' " if resultado
