require "test_helper"

class TimeEntryTest < ActiveSupport::TestCase
  setup do
    @entry = time_entries(:one)
    @entry_two = time_entries(:two)
  end

  test "real_duration works for running entries" do
    @entry_two.update!(start_time: Time.new(2018, 3, 17, 20), running: true)
    travel_to Time.new(2018, 3, 17, 21) do
      assert_equal 60, @entry_two.real_duration
    end
  end
end
