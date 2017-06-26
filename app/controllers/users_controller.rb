class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :ensure_admin, except: [:new, :create]
  before_action :find_user, only: [:show, :edit, :update, :send_email, :destroy]

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
        html = render_to_string(layout: "pdf_layout", action: 'pdf/show.html')
        pdf = WickedPdf.new.pdf_from_string(html)
        
        send_data(pdf,
                  filename: "user_info_#{@user.id}.pdf",
                  disposition: 'attachment')
      end
    end
  end

  def edit; end

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
    if @user.destroy
      flash[:success] = 'User was deleted'
    else
      flash[:alert] = 'Sorry, user was not deleted because of an error'
    end
    redirect_to users_url
  end

  def send_email
    UserMailer.user_profile(@user).deliver
    flash[:success] = "Email was sent to #{UserMailer::MAIL_TO}"
    redirect_to user_url(@user)
  end

  protected

  def user_params
    params.require(:user).permit(:firstname, :lastname, :birthdate, :biography, :email, :avatar,
                                 :password, :password_confirmation)
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
