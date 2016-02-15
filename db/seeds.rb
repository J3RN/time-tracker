User.create!(username: 'J3RN', display_name: 'J3RN',
             email: 'jonarnett90@gmail.com', password: 'blargblarg')

Customer.create!([
  { company: 'Dell' },
  { company: 'Mozilla' }])

Customer.first.projects.create!([
  { project_name: 'Project 1' },
  { project_name: 'Project 2' }])

Project.first.tasks.create!([
  { task_name: 'Development' },
  { task_name: 'Management' }])
