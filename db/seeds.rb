User.create!(username: 'J3RN', display_name: 'J3RN',
             email: 'jonarnett90@gmail.com', password: 'blargblarg')

Tag.create!([
  { name: 'Dell' },
  { name: 'Mozilla' },
  { task_name: 'Development' },
  { task_name: 'Management' }])
