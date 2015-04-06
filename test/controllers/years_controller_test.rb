require 'test_helper'

class YearsControllerTest < ActionController::TestCase
  setup do
    @year = years(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:years)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create year" do
    assert_difference('Year.count') do
      post :create, year: { mark_id: @year.mark_id, model_id: @year.model_id, year: @year.year }
    end

    assert_redirected_to year_path(assigns(:year))
  end

  test "should show year" do
    get :show, id: @year
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @year
    assert_response :success
  end

  test "should update year" do
    patch :update, id: @year, year: { mark_id: @year.mark_id, model_id: @year.model_id, year: @year.year }
    assert_redirected_to year_path(assigns(:year))
  end

  test "should destroy year" do
    assert_difference('Year.count', -1) do
      delete :destroy, id: @year
    end

    assert_redirected_to years_path
  end
end
