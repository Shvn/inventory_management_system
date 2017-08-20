class BrandsController < ApplicationController
  before_action :check_if_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :get_brand, only: [:show, :edit, :update, :destroy]

  def index
    @brands = Brand.all
  end

  def show
  end

  def new
    @brand = Brand.new
  end

  def edit
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      flash[:success] = "Brand successfully created"
      redirect_to @brand
    else
      render 'new'
    end
  end

  def update
    if @brand.update(brand_params)
      flash[:success] = "Brand successfully updated"
      redirect_to @brand
    else
      render 'edit'
    end
  end

  def destroy
    @brand.destroy
    flash[:success] = "Brand successfully deleted"
    redirect_to brands_path
  end

  private

    def get_brand
      @brand = Brand.find(params[:id])
    end

    def brand_params
      params.require(:brand).permit(:name)
    end
end
