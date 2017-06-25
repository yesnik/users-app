class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin
  before_action :find_user, only: [:show]

  def index
    @users = User.all
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  protected

  def ensure_admin
    return if current_user.admin?
    flash[:notice] = 'Sorry... Only admin has access to that page.'
    redirect_to :root
  end

  def find_user
    @user = User.find(params[:id])
  end
end
