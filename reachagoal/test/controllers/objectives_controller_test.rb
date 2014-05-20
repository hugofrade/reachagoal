require 'test_helper'

class ObjectivesControllerTest < ActionController::TestCase
  setup do
    @objective = objectives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:objectives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create objective" do
    assert_difference('Objective.count') do
      post :create, objective: { description: @objective.description, end_day: @objective.end_day, name: @objective.name, objective_type: @objective.objective_type, price: @objective.price, privacy: @objective.privacy, start_day: @objective.start_day }
    end

    assert_redirected_to objective_path(assigns(:objective))
  end

  test "should show objective" do
    get :show, id: @objective
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @objective
    assert_response :success
  end

  test "should update objective" do
    patch :update, id: @objective, objective: { description: @objective.description, end_day: @objective.end_day, name: @objective.name, objective_type: @objective.objective_type, price: @objective.price, privacy: @objective.privacy, start_day: @objective.start_day }
    assert_redirected_to objective_path(assigns(:objective))
  end

  test "should destroy objective" do
    assert_difference('Objective.count', -1) do
      delete :destroy, id: @objective
    end

    assert_redirected_to objectives_path
  end
end
