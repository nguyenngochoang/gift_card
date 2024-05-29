class Api::V1::ProductsController < Api::V1::BaseController
  before_action :set_brand
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    @products = @brand.products
    render json: @products, each_serializer: ProductSerializer
  end

  def show
    render json: @product, user_currency: params[:currency]
  end

  def create
    @product = @brand.products.new(product_params)
    if @product.save
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.update(deleted_at: Time.now)
      render json: @product
    else
      render json: { error: 'Failed to delete product' }, status: :unprocessable_entity
    end
  end

  private

  def set_brand
    @brand = current_api_v1_user.brands.find_by(id: params[:brand_id])
    render json: { error: 'Brand not found' }, status: :not_found unless @brand
  end

  def set_product
    @product = current_api_v1_user.products.find_by(id: params[:id])
    render json: { error: 'Product not found' }, status: :not_found unless @product
  end

  def product_params
    params[:product][:user_id] = current_api_v1_user.id
    params.require(:product).permit(:name, :price_cents, :price_currency, :user_id, custom_fields_attributes: [:key, :value])
  end
end
