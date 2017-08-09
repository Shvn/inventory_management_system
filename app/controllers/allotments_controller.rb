class AllotmentsController < ApplicationController
  before_action :get_allotment, only: [:show, :update, :destroy]

  def index
    @allotments = Allotment.includes(:item, :person).all.order_descending
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
      params.require(:allotment).permit(:item_id, :person_id, :status)
    end
end
