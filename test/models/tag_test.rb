require 'test_helper'

class TagTest < ActiveSupport::TestCase
  setup do
    @tag = tags(:one)
    @task = tasks(:one)
  end

  test "does not orphan taggings" do
    before_taggings = Tagging.count

    @tag.save!
    @tag.tasks << @task

    # Assert tagging was created
    assert_equal(Tagging.count, before_taggings + 1)

    @tag.destroy

    # Assert tagging was destroyed
    assert_equal(Tagging.count, before_taggings)
  end
end
