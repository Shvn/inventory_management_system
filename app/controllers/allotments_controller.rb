class AllotmentsController < ApplicationController
  include AllotmentsHelper

  after_action :check_quantity, only: [:create, :update, :destroy]
  after_action :decrement_quantity, only: [:create, :update]
  after_action :increment_quantity, only: [:destroy]
  before_action :get_allotment, only: [:show, :update, :destroy]
  before_action :get_item, only: [:create, :update, :destroy]

  def index
    @allotments = Allotment.includes(:item, :user).all.order_descending
  end

  def new
    @allotment = Allotment.new
  end

  def create
    default = { status: "Allocated" }
    @allotment = Allotment.new(allotment_params.merge(default))
    
    if @item.available?
      @allotment.save
      flash[:success] = "Allotment successful"
      redirect_to @allotment
    else
      render 'new'
    end
  end

  def show
  end

  def update
    default = { status: "Allocated" }
    if @item.available?
      @allotment.update(default)
      flash[:success] = "Successfully re-allocated"
    else
      flash[:danger] = "Item is out of stock"
    end
    redirect_to allotment_path
  end

  def destroy
    default = { status: "Deallocated" }
    if @allotment.update(default)
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
