require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @non_admin = users(:archer)
  end
  
  test "layout links when user is not logged in" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path
    get signup_path
    assert_select "title", full_title("Sign up")
  end

  test "layout links when user is logged in" do
    log_in_as(@non_admin)
    get root_path
    assert_select "a[href=?]", users_path
    # assert_select "a[href=?]", current_user
    # assert_select "a[href=?]", edit_user_path(current_user)
    assert_select "a[href=?]", logout_path
  end
  
end