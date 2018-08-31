require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:fidel)
    remember(@user)
  end

  test "current_user returns right user whne session is nil" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "current_user returns nil when remmebeer digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
  end
end