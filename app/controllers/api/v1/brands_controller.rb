class Api::V1::BrandsController < Api::V1::BaseController

  def index
    brands = Brand.all
    render json: brands
  end

  def create
    brand = current_api_v1_user.brands.new(brand_params)
    if brand.save
      render json: brand
    else
      render json: { errors: brand.errors }, status: 422
    end
  end

  private

  def brand_params
    params.require(:brand).permit(:name, custom_fields_attributes: [:key, :value])
  end
end
