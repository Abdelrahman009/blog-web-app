require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid sign up"do
    get new_user_path
    assert_no_difference User.count.to_s do
    post users_path, params:{ user: {
          first_name:"",
          last_name:"",
          password:"",
          password_confirmation:"",
          email:""
      }
    }
    end
    assert_template 'users/new'
  end
end
