require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "| Ruby On Rails Tutorial"
  end
  
  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "HOME #{@base_title}"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "HELP #{@base_title}"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "ABOUT #{@base_title}"
  end
end