# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(email: 'a@a.a', password: 'password', password_confirmation: 'password')
Admin.create(email: 'b@b.b', password: 'password', password_confirmation: 'password')
Admin.create(email: 'c@c.c', password: 'password', password_confirmation: 'password')

teacher_a = Teacher.create(email: 'a@a.a', password: 'aaaaaa', password_confirmation: 'aaaaaa')
Teacher.create(email: 'b@b.b', password: 'bbbbbb', password_confirmation: 'bbbbbb')
Teacher.create(email: 'c@c.c', password: 'cccccc', password_confirmation: 'cccccc')

Student.create(email: 'a@a.a', password: 'aaaaaa', password_confirmation: 'aaaaaa')
Student.create(email: 'b@b.b', password: 'bbbbbb', password_confirmation: 'bbbbbb')
Student.create(email: 'c@c.c', password: 'cccccc', password_confirmation: 'cccccc')

course_a = Course.create(name: 'a', description: 'a', status: 'public', teacher_id: teacher_a.id)
Course.create(name: 'b', description: 'b', status: 'public', teacher_id: teacher_a.id)
Course.create(name: 'c', description: 'c', status: 'draft', teacher_id: teacher_a.id)

tag_a = Tag.create([{name: 'a'}, {name: 'b'}, {name: 'c'}]).first

Lesson.create(name: 'a', description: 'a', content: 'a', transcript: 'a', video_url: 'a', dir_url: 'a', course: course_a, tags: [tag_a], status: 'public')
Lesson.create(name: 'b', description: 'b', content: 'b', transcript: 'b', video_url: 'b', dir_url: 'b', course: course_a, tags: [tag_a], status: 'public')
Lesson.create(name: 'c', description: 'c', content: 'c', transcript: 'c', video_url: 'c', dir_url: 'c', course: course_a, tags: [tag_a], status: 'draft')
