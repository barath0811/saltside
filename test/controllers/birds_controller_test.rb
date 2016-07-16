require 'test_helper'
require 'pry'

class BirdsControllerTest < ActionController::TestCase
  setup do
    @bird = Bird.new
    @bird.name = "bird1"
    @bird.family = "family1"
    @bird.continents = ['asia']
    @bird.visible = true
    @bird.save
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:birds)
  end

  test "should create bird" do
    assert_difference('Bird.count') do
      post :create, { continents: ['Asia'], family: 'Family1', name: 'Name1' }
    end

    assert_response 201

    assert_no_difference('Bird.count') do
      post :create, { family: 'Family1', name: 'Name1' }
    end

    assert_response 400

    assert_difference('Bird.count') do
      post :create, { continents: ['Asia', 'Asia'], family: 'Family1', name: 'Name1' }
    end

    assert_response 201

    assert_difference('Bird.count') do
      post :create, { continents: ['Asia'], family: 'Family1', name: 'Name1', visible: true }
    end

    assert_response 201
  end

  test "should show bird" do
    get :show, id: @bird
    assert_response :success
  end

  test "should not show invalid bird id" do
    get :show, id: -1
    assert_response 404

    get :show, id: 'bird1'
    assert_response 404
  end

  test "should destroy bird" do
    assert_difference('Bird.count', -1) do
      delete :destroy, id: @bird
    end

    assert_response 200
  end

  test "should not destroy invalid bird id" do
    assert_no_difference('Bird.count') do
      delete :destroy, id: -1
    end

    assert_response 404

    assert_no_difference('Bird.count') do
      delete :destroy, id: 0
    end

    assert_response 404
  end
end
