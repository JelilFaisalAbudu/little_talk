require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "should not add new user with invalid information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name: ' ',
          email: 'user@invalid',
          password: 'foo',
          password_confirmation: 'foo'
        }
      }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test 'should sign up new user with valid information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {
        user: {
          name: 'Example User',
          email: 'user@example.com',
          password: '1234567890',
          password_confirmation: '1234567890'
        }
      }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
