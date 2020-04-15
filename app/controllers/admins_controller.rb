class AdminsController < ApplicationController
  #before_action :authorize_admin

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    admin = Admin.create(admin_params)
    if admin.id
      # TODO: signing in as new user likely isn't necessary in this context for any type of user.
      session[:user_id] = admin.id
      session[:type] = 'admin'
      session[:privilege] = 'admin'

      redirect_to admins_path
    else
      show_error(admin)
      flash[:error] = "Couldn\'t create admin.<br />" + flash[:error]
      redirect_to admins_path
    end
  end

  def show
    @admin = Admin.find_by(id: params[:id])
  end

  def edit
    @admin = Admin.find_by(id: params[:id])
  end

  def update
    #validate, update pw if present
    #must input old pw to update pw
    admin = Admin.find_by(id: params[:id])
    admin.update(admin_params)
    admin ? redirect_to(admins_path) : render('Couldn\'t create admin.')

  end

  def destroy
    id = params[:id]
    @admin = Admin.find_by(id: id)
    @admin.destroy

    if session[:type] == 'admin' && session[:user_id] == id
      reset_session
      return redirect_to root_path
    end

    redirect_to admins_path
  end

  private
  def authorize_admin
    unless session[:privilege] == 'admin'
      flash[:error] = 'Only admins can view /admins.'
      redirect_to "/" # halts request cycle
    end
  end

  def show_error(object)
    if object.errors.any?
      flash[:error] = ''
      object.errors.full_messages.each do |message|
        flash[:error] = flash[:error] + "#{message}<br />"
      end
    end
  end

  def admin_params
    params.require(:admin).permit(:username, :password, :password_confirmation)
  end
end
