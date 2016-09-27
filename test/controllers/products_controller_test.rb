require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:ruby)
      @update = {
        title: 'Lorem',
        description: 'wibble',
        image_url: 'lorem.jpg',
        price: 19.95
      }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: @update
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: @update 
    assert_redirected_to product_path(assigns(:product))
  end


test "product has line items" do
  assert_not_equal 0, @product.line_items.count
end

test "product has no line items" do
  @product.line_items.each do |item|
    item.destroy
  end

  assert_equal 0, @product.line_items.count
end

test "should destroy product" do
    assert_difference('Product.count', -1) do

    # "simulate" a product that has never been added to cart
    # alternatively you could update your fixtures to do this

    @product.line_items.each do |item|
      item.destroy
    end

    delete :destroy, id: @product
  end

  assert_redirected_to products_path
end
end
