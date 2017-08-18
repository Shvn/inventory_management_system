class AllotmentsController < ApplicationController
  before_action :get_allotment, only: [:show, :update, :destroy]
  before_action :check_quantity, only: [:update_buffer]
  after_action :decrement_quantity, only: [:create, :update]
  after_action :incement_quantity, only: [:destroy]

  def index
    @allotments = Allotment.includes(:item, :user).all.order_descending
  end

  def new
    @allotment = Allotment.new
  end

  def create
    default = { status: "Allocated" }
    @allotment = Allotment.new(allotment_params.merge(default))

    if @allotment.save
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
    if @allotment.update(default)
      flash[:success] = "Successfully allocated"
    else
      flash[:danger] = "Could not allocate"
    end
    redirect_to allotments_path
  end

  def destroy
    default = { status: "Deallocated" }
    if @allotment.update(default)
      flash[:success] = "Successfully deallocated"
    else
      flash[:danger] = "Could not deallocate"
    end
    redirect_to allotments_path
  end

  def history
    @allotment_histories = AllotmentHistory.find_histories(params[:id]).order_descending
  end

  private

    def get_allotment
      @allotment = Allotment.find(params[:id])
    end

    def allotment_params
      params.require(:allotment).permit(:item_id, :user_id, :status)
    end

    def check_quantity
      notify_admin if buffer_quantity_reached
    end

    def increment_quantity
      item = Item.find(@allotment.item_id)
      item.increment!(:quantity)
    end

    def decrement_quantity
      item = Item.find(@allotment.item_id)
      item.decrement!(:quantity)
    end

    def notify_admin
    end
end
