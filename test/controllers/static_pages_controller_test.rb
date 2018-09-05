require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success

    assert_select "title","Home TwitterApp"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title","Help TwitterApp"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title","About TwitterApp"
  end

  test "should get contacts" do
    get static_pages_contacts_url
    assert_response :success
    assert_select "title","Contacts TwitterApp"
  end

end
