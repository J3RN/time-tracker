class DefaultDurationToZero < ActiveRecord::Migration[4.2]
  def change
    change_column_default :time_entries, :duration, 0
  end
end
