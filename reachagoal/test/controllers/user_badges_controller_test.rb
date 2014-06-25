require 'test_helper'

class UserBadgesControllerTest < ActionController::TestCase
  setup do
    @user_badge = user_badges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_badges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_badge" do
    assert_difference('UserBadge.count') do
      post :create, user_badge: { badge_id: @user_badge.badge_id, user_id: @user_badge.user_id }
    end

    assert_redirected_to user_badge_path(assigns(:user_badge))
  end

  test "should show user_badge" do
    get :show, id: @user_badge
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_badge
    assert_response :success
  end

  test "should update user_badge" do
    patch :update, id: @user_badge, user_badge: { badge_id: @user_badge.badge_id, user_id: @user_badge.user_id }
    assert_redirected_to user_badge_path(assigns(:user_badge))
  end

  test "should destroy user_badge" do
    assert_difference('UserBadge.count', -1) do
      delete :destroy, id: @user_badge
    end

    assert_redirected_to user_badges_path
  end
end
