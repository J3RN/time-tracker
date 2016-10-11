class DefaultDurationToZero < ActiveRecord::Migration
  def change
    change_column_default :time_entries, :duration, 0
  end
end
