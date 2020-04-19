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

course_a = Course.create(name: 'a', description: 'aaaaaaaaaa', status: 'public', teacher_id: teacher_a.id)
Course.create(name: 'b', description: 'bbbbbbbbbb', status: 'public', teacher_id: teacher_a.id)
Course.create(name: 'c', description: 'cccccccccc', status: 'draft', teacher_id: teacher_a.id)

tag_a = Tag.create([{name: 'a'}, {name: 'b'}, {name: 'c'}]).first

Lesson.create(name: 'a', description: 'aaaaaaaaaa', content: 'aaaaaaaaaa', transcript: 'a', video_url: 'https://www.youtube.com/embed/C0DPdy98e4c', course: course_a, tags: [tag_a], status: 'public')
Lesson.create(name: 'b', description: 'bbbbbbbbbb', content: 'bbbbbbbbbb', transcript: 'b', video_url: 'https://www.youtube.com/embed/C0DPdy98e4c', course: course_a, tags: [tag_a], status: 'public')
Lesson.create(name: 'c', description: 'cccccccccc', content: 'cccccccccc', transcript: 'c', video_url: 'https://www.youtube.com/embed/C0DPdy98e4c', course: course_a, tags: [tag_a], status: 'draft')
