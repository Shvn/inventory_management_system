class IssuesController < ApplicationController
  include IssuesHelper

  before_action :get_issue, only: [:show, :edit, :update, :resolve]
  before_action :is_author, only: [:edit, :update]
  before_action :check_if_admin, only: [:resolve]

  def index
    @issues = Issue.includes(:user, :item).all
  end

  def show
  end

  def new
    @issue = Issue.new
  end

  def edit
  end

  def create
    default = { user_id: current_user.id, status: 'Raised' }
    @issue = Issue.new(issue_params.merge(default))

    if @issue.save
      flash[:success] = "Issue successfully created"
      redirect_to @issue
    else
      render 'new'
    end
  end

  def update
    default = { user_id: current_user.id, status: 'Raised' }
    if @issue.update(issue_params.merge(default))
      flash[:success] = "Issue successfully updated"
      redirect_to @issue
    else
      render 'edit'
    end
  end

  def resolve
    default = { status: 'Solved' }
    if @issue.update(default)
      notify_user
      flash[:success] = "Issue successfully solved"
      redirect_to @issue
    else
      render 'edit'
    end
  end

  private

    def get_issue
      @issue = Issue.find(params[:id])
    end

    def issue_params
      params.require(:issue).permit(:user_id, :item_id, :details, :status).merge(user_id: current_user)
    end
end
