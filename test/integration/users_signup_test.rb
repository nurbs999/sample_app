require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
    test "invalid signup information" do
        get signup_path
        assert_no_difference 'User.count' do
            post users_path, params: { user: { name: "",
                email: "invalid@email",
                password: "gna",
                password_confirmation: "toshort"}
            }
        end
        assert_template 'users/new'
        assert_select 'div#error_explanation'
        assert_select 'div.alert-danger'
        assert_select 'li.error-message', 4
    end

    test "valid signup" do
        get signup_path
        assert_difference( 'User.count', 1 ) do
            post users_path, params: { user: { name: "valid test user",
                email: "valid@email.com",
                password: "gnagna",
                password_confirmation: "gnagna"}
            }
        end
        valid_user = User.last
        assert_redirected_to valid_user
        follow_redirect!
        assert_template 'users/show'
        assert_not flash.empty?
        assert_select 'div.alert-success'
    end
end