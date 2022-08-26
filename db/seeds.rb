# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.all.each do |u|
  u.destroy
end
Task.all.each do |u|
  u.destroy
end
Section.all.each do |u|
  u.destroy
end
UserTask.all.each do |u|
  u.destroy
end
UserProject.all.each do |u|
  u.destroy
end
Project.all.each do |p|
  p.destroy
end
