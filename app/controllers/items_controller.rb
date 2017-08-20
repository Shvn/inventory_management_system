class ItemsController < ApplicationController
  before_action :check_if_admin, only: [:new, :create, :edit, :update]
  before_action :get_item, only: [:show, :edit, :update]

  def index
    @items = Item.all
  end

  def show
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      flash[:success] = "Item successfully created"
      redirect_to @item
    else
      render 'new'
    end
  end

  def update
    if @item.update(item_params)
      flash[:success] = "Item successfully updated"
      redirect_to @item
    else
      render 'edit'
    end
  end

  def allotment
    @allotments = Allotment.find_item_allotments(params[:id]).order_descending
  end

  def history
    @allotment_histories = AllotmentHistory.find_item_histories(params[:id]).order_descending
  end

  private

    def get_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :category_id, :brand_id, :quantity, :time_of_procurement, :buffer_quantity)
    end
end
