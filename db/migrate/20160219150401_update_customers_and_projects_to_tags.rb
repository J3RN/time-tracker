class Customer < ActiveRecord::Base
end

class Project < ActiveRecord::Base
end

class UpdateCustomersAndProjectsToTags < ActiveRecord::Migration
  def up
    # Convert all Customers and Projects to Tags
    Customer.all.each do |customer|
      tag = Tag.find_or_create_by!(name: customer.company)
      customer.tasks.each { |task| task.tags << tag }
    end

    Project.all.each do |project|
      tag = Tag.find_or_create_by!(name: project.project_name)
      project.tasks.each { |task| task.tags << tag }
    end
  end

  def down
    # Destroy all tags with these names
    Customer.all.each do |customer|
      Tag.where(name: customer.company).destroy_all
    end

    Project.all.each do |project|
      Tag.where(name: project.project_name).destroy_all
    end
  end
end
