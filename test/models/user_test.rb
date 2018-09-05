require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(first_name:"Abdo",last_name: "ibrahim",email:"foo@bar.com", password:"123456", password_confirmation:"123456")
  end

  test "the fields are not blank" do
    assert @user.valid?

  end
  test "the fields are blank" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "the name is too long" do
    @user.first_name = "a"*51
    assert_not @user.valid?
  end

  test "the password is too short" do
    @user.password = "132"
    assert_not @user.valid?
  end

  test "valid mail" do
    assert @user.valid?
  end
  test "the mail is not valid" do
    @user.email  = "a"
    assert_not @user.valid?
  end

  test "the email should be unique" do
    duplicate = @user.dup
    duplicate.save
    assert_not @user.valid?
  end

end
