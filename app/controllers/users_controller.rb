class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin
  before_action :find_user, only: [:show, :edit, :update]

  def index
    @users = User.not_admin
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User was created'
      redirect_to users_path
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html do
        render :show
      end

      format.pdf do
        # pdf = WickedPdf.new.pdf_from_string('Hello There!')

        html = render_to_string(layout: "pdf_layout", action: 'pdf/show.html')
        pdf = WickedPdf.new.pdf_from_string(html)
        
        send_data(pdf,
                  filename: "user_info_#{@user.id}.pdf",
                  disposition: 'attachment')
      end
    end
  end

  def edit
  end

  def update
    @user.update(user_params)
    if @user.save
      flash[:success] = 'User\'s information was updated!'
      redirect_to user_path @user
    else
      render :edit
    end
  end

  def destroy
  end

  protected

  def user_params
    params.require(:user).permit(:firstname, :lastname, :birthdate, :biography, :email, :password)
  end

  def ensure_admin
    return if current_user.admin?
    flash[:notice] = 'Sorry... Only admin has access to that page.'
    redirect_to :root
  end

  def find_user
    @user = User.find(params[:id])
  end
end
