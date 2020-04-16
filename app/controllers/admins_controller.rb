class AdminsController < ApplicationController
  include Accessible
  skip_before_action :check_user
  #before_action :authorize_admin

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    admin = Admin.new(admin_params)
    if admin.valid?
      admin.save
      redirect_to admins_path
    else
      flash[:error] = 'Could not create admin.'
      redirect_to new_admin_path
    end
  end

  def show
    @admin = Admin.find_by(id: params[:id])
    @visitor_is_self = visitor_is_self?
  end

  def edit
    @admin = Admin.find_by(id: params[:id])
  end

  def update
    admin = Admin.find_by(id: params[:id])
    Admin.validators_on(params[:admin][:email])
    #admin.validate_email(params[:admin][:email])

    #is email invalid?
    if admin.errors.size > 0
      flash[:error] = "Email invalid. You input: '#{params[:admin][:email]}'."
      redirect_to edit_admin_path

    #are passwords empty?
    elsif params[:admin][:password] == '' && params[:admin][:password_confirmation] == ''
      admin.update_attribute('email', params[:admin][:email])
      flash[:notice] = 'Email updated successfully.'
      redirect_to admin

    #passwords don't match?
    elsif params[:admin][:password] != params[:admin][:password_confirmation]
      flash[:error] = "Passwords don\'t match."
      redirect_to edit_admin_path

    #passwords match?
    elsif (params[:admin][:password] == params[:admin][:password_confirmation]) && params[:admin][:password].length > 5
      admin.update(admin_params)
      flash[:notice] = 'Email and/or password updated successfully.'
      redirect_to admin
    else
      redirect_to edit_admin_path
    end
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
