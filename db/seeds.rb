# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(username: 'a', password: 'password', password_confirmation: 'password')
Admin.create(username: 'b', password: 'password', password_confirmation: 'password')
Admin.create(username: 'c', password: 'password', password_confirmation: 'password')

teacher_a = Teacher.create(username: 'a', password: 'a', password_confirmation: 'a')
Teacher.create(username: 'b', password: 'b', password_confirmation: 'b')
Teacher.create(username: 'c', password: 'c', password_confirmation: 'c')

Student.create(username: 'a', password: 'a', password_confirmation: 'a')
Student.create(username: 'b', password: 'b', password_confirmation: 'b')
Student.create(username: 'c', password: 'c', password_confirmation: 'c')

Course.create(name: 'a', description: 'a', teacher: teacher_a)
Course.create(name: 'b', description: 'b', teacher: teacher_a)
Course.create(name: 'c', description: 'c', teacher: teacher_a)
