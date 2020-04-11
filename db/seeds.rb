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

course_a = Course.create(name: 'a', description: 'a', teacher: teacher_a)
Course.create(name: 'b', description: 'b', teacher: teacher_a)
Course.create(name: 'c', description: 'c', teacher: teacher_a)

tag_a = Tag.create([{name: 'a'}, {name: 'b'}, {name: 'c'}]).first

Lesson.create(name: 'a', description: 'a', content: 'a', transcript: 'a', video_url: 'a', dir_url: 'a', course: course_a, tags: [tag_a])
Lesson.create(name: 'b', description: 'b', content: 'b', transcript: 'b', video_url: 'b', dir_url: 'b', course: course_a, tags: [tag_a])
Lesson.create(name: 'c', description: 'c', content: 'c', transcript: 'c', video_url: 'c', dir_url: 'c', course: course_a, tags: [tag_a])
