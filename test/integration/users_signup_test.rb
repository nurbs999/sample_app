require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
    test "invalud signup information" do
        get signup_path
        assert_no_difference 'User.count' do
            post users_path, params: { user: { name: "",
                email: "invalid@email",
                password: "gna",
                password_validation: "toshort"}
            }
        end
        assert_template 'users/new'
        assert_select 'div#error_explanation'
        assert_select 'div.alert-danger'
        assert_select "li.error-message", 3
    end
end