require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Test user", email: "valid@email.com")
  end

  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "name should be maximum 51 chars long" do
    @user.name = "a"*51
    assert_not @user.valid?
  end

  test "email should be maximum 255 chars long" do
    @user.email = "a"*246+"@email.com"
    assert_not @user.valid?
  end

  test "should accept valid email adresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |email|
      @user.email = email
      assert @user.valid?, "#{email.inspect} should be valid"
    end
  end

  test "email validation should reject invalid emails" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email} should not be valid"
    end
  end

  test "email should be unique" do
    duplicate = @user.dup
    @user.save
    assert_not duplicate.valid?
  end

  test "email should be saved downcase" do
    mixed_case_email = "fOo@Bar.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
end
