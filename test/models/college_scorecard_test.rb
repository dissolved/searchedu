require "test_helper"

class CollegeScorecardTest < ActiveSupport::TestCase
  test "#search without passing a block" do
    mock = Minitest::Mock.new
    mock.expect(:first, [:some, :data])

    PaginatedRequest.stub(:new, mock) do
      CollegeScorecard.schools.search({ 'school.name' => 'poly' })
    end
    assert_mock mock
  end

  test "#search with a block" do
    mock = Minitest::Mock.new
    mocked_data = [:some, :data]
    mock.expect(:each, mocked_data)

    PaginatedRequest.stub(:new, mock) do
      CollegeScorecard.schools.search({ 'school.name' => 'poly' }) { |data| assert_equal(mocked_data, data) }
    end
    assert_mock mock
  end
end
