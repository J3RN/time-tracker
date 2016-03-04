class RemoveOrphans < ActiveRecord::Migration
  def change
    Tagging.all.each do |tagging|
      tagging.destroy if tagging.tag.nil? || tagging.task.nil?
    end
    TimeEntry.all.each { |te| te.destroy if te.task.nil? || te.user.nil? }
    Task.all.each { |task| task.destroy if task.user.nil? }
    Tag.all.each { |tag| tag.destroy if tag.user.nil? }
  end
end
