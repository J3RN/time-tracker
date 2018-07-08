class ApplicationHelperTest < ActionView::TestCase
  test "std_date" do
    assert_dom_equal "Saturday, July 7th", std_date(Date.parse('2018-07-07'))
  end

  test "duration_display" do
    assert_dom_equal "34:56", duration_display(2096)
    assert_dom_equal "11:11", duration_display(671)
    assert_dom_equal "00:00", duration_display(0)
  end

  test "long_duration_display" do
    assert_dom_equal "34 hours and 56 minutes", long_duration_display(2096)
    assert_dom_equal "11 hours and 11 minutes", long_duration_display(671)
    assert_dom_equal "1 hour and 2 minutes", long_duration_display(62)
    assert_dom_equal "2 hours and 1 minute", long_duration_display(121)
    assert_dom_equal "0 hours and 0 minutes", long_duration_display(0)
  end
end
