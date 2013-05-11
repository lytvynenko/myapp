require 'test_helper'

class FeaturedCharitiesControllerTest < ActionController::TestCase
  setup do
    @featured_charity = featured_charities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:featured_charities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create featured_charity" do
    assert_difference('FeaturedCharity.count') do
      post :create, featured_charity: { address: @featured_charity.address, cn_id: @featured_charity.cn_id, ein: @featured_charity.ein, fg_uuid: @featured_charity.fg_uuid, image: @featured_charity.image, name: @featured_charity.name }
    end

    assert_redirected_to featured_charity_path(assigns(:featured_charity))
  end

  test "should show featured_charity" do
    get :show, id: @featured_charity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @featured_charity
    assert_response :success
  end

  test "should update featured_charity" do
    put :update, id: @featured_charity, featured_charity: { address: @featured_charity.address, cn_id: @featured_charity.cn_id, ein: @featured_charity.ein, fg_uuid: @featured_charity.fg_uuid, image: @featured_charity.image, name: @featured_charity.name }
    assert_redirected_to featured_charity_path(assigns(:featured_charity))
  end

  test "should destroy featured_charity" do
    assert_difference('FeaturedCharity.count', -1) do
      delete :destroy, id: @featured_charity
    end

    assert_redirected_to featured_charities_path
  end
end
