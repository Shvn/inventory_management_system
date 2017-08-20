class AllotmentsController < ApplicationController
  include AllotmentsHelper

  before_action :check_if_admin, only: [:new, :create, :update, :destroy]
  before_action :get_allotment, only: [:show, :update, :destroy]
  before_action :get_item, only: [:update, :destroy]

  def index
    @allotments = Allotment.includes(:item, :user).all.order_descending
  end

  def new
    @allotment = Allotment.new
  end

  def create
    default = { status: "Allocated" }
    @allotment = Allotment.new(allotment_params.merge(default))
    get_item
    if @item.available?
      if @allotment.save
        decrement_quantity
        flash[:success] = "Allotment successful"
        redirect_to @allotment
      else
        render 'new'
      end
    else
      @allotment.errors.add(:item, " is out of stock")
      render 'new'
    end
  end

  def show
  end

  def update
    default = { status: "Allocated" }
    if @item.available?
      if @allotment.update(default)
        decrement_quantity
        flash[:success] = "Successfully re-allocated"
      else
        flash[:danger] = 'Could not allocate'
      end
    else
      flash[:warning] = "Item is out of stock"
    end
    redirect_to allotment_path
  end

  def destroy
    default = { status: "Deallocated" }
    if @allotment.update(default)
      increment_quantity
      flash[:success] = "Successfully deallocated"
    else
      flash[:danger] = "Could not deallocate"
    end
    redirect_to allotment_path
  end

  def history
    @allotment_histories = AllotmentHistory.find_histories(params[:id]).order_descending
  end

  private

    def get_allotment
      @allotment = Allotment.find(params[:id])
    end

    def get_item
      @item = Item.find(@allotment.item_id)
    end

    def allotment_params
      params.require(:allotment).permit(:item_id, :user_id, :status)
    end
end
