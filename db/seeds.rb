j3rn = User.create!(username: 'J3RN', display_name: 'J3RN',
             email: 'jonarnett90@gmail.com', password: 'blargblarg')

test = User.create!(username: 'Test User', display_name: 'Test User',
             email: 'test@example.com', password: 'foobarbar')

User.create!(username: 'ADMIN', display_name: 'ADMIN', admin: true,
             email: 'admin@example.com', password: 'foobarbar')

j3rn_tags = j3rn.tags.create!([
  { name: 'Homework' },
  { name: 'Personal' },
  { name: 'Projects' }
])

j3rn_tasks = j3rn_tags.first.tasks.create!([
  { task_name: 'Homework #5', priority: 4, user_id: j3rn.id },
  { task_name: 'Homework #4', user_id: j3rn.id },
  { task_name: 'Homework #3', priority: 3, archived: true, user_id: j3rn.id }
])

j3rn_tasks.first.time_entries.create!([
  { goal: 'Finish #1', result: 'Done', start_time: Time.now, duration: 25 }
])

test_tags = test.tags.create!([
  { name: 'Foobar' },
  { name: 'Test User Tag' }
])

test_tags.last.tasks.create!([
  { task_name: 'Testing things', user_id: test.id }
])
