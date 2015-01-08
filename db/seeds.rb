User.create!(username: 'J3RN', display_name: 'J3RN', email: 'j3rn@j3rn.com', password: 'blargblarg')

Task.create!(
  { task_name: 'Development' },
  { task_name: 'Management' })

Customer.create!(
  { company: 'covermymeds' },
  { company: 'Dell' },
  { company: 'Mozilla' })

Customer.first.projects.create!(
  { project_name: 'Project 1' },
  { project_name: 'Project 2' }
)
