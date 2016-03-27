require 'test_helper'

class TrendsControllerTest < ActionController::TestCase
  setup do
    @trend = trends(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trends)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trend" do
    assert_difference('Trend.count') do
      post :create, trend: { group_id: @trend.group_id, keyword: @trend.keyword, rank: @trend.rank }
    end

    assert_redirected_to trend_path(assigns(:trend))
  end

  test "should show trend" do
    get :show, id: @trend
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trend
    assert_response :success
  end

  test "should update trend" do
    patch :update, id: @trend, trend: { group_id: @trend.group_id, keyword: @trend.keyword, rank: @trend.rank }
    assert_redirected_to trend_path(assigns(:trend))
  end

  test "should destroy trend" do
    assert_difference('Trend.count', -1) do
      delete :destroy, id: @trend
    end

    assert_redirected_to trends_path
  end
end
