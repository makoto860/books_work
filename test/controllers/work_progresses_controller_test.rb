require "test_helper"

class WorkProgressesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get work_progresses_index_url
    assert_response :success
  end
end
