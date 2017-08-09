class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)

    if @person.save
      flash[:success] = "Person successfully created"
      redirect_to people_path
    else
      render 'new'
    end
  end

  def allotment
    @allotments = Allotment.find_person_allotments(params[:id]).order_descending
  end

  private

    def person_params
      params.require(:person).permit(:name, :email, :mobile)
    end
end
