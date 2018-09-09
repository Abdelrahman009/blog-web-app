require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @micropost =
        Micropost.new(first_name:"Abdo",
                      last_name: "ibrahim",
                      email:"foo@bar.com",
                      password:"123456",
                      password_confirmation:"123456")
  end

  test "the fields are not blank" do
    assert @micropost.valid?
  end

  test "user id should be present" do

  end


end
