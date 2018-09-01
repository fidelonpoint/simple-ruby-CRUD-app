require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:fidel)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "", email: "not@valid",
                                              password: "not", password_confirmation: "vad"}}
    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
   # assert_template 'users/edit'
    assert_redirected_to edit_user_url(@user)
    name = "Fidel Oka"
    email = "fidel@vad.com"
    patch user_path(@user), params: { user: { name: name, email: email, password: "", password_confirmation: ""}}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
