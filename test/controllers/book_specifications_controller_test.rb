require "test_helper"

class BookSpecificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get book_specifications_index_url
    assert_response :success
  end
end
