require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin=users(:michael)
    @other=users(:archer)
  end 
  
  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users= User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user),text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end 
    end
    assert_difference 'User.count', -1 do
      delete user_path(@other)
    end
  end
  
  test "index as non admin" do
    log_in_as(@other)
    assert_no_difference 'User.count' do
      delete user_path(@admin)
    end 
  end 
  
  
end
