class AdminsController < ApplicationController
  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    admin = Admin.create(admin_params)
    if admin
      redirect_to admins_path
    else
      'Couldn\'t create admin.'
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

    admin = Admin.update(admin_params)
    admin ? redirect_to admins_path : render 'Couldn\'t create admin.'
    end
  end

  def destroy
    @admin = Admin.find_by(id: params[:id])
    @admin.destroy
    redirect_to admins_path
  end

  def admin_params
    params.require(:admin).permit(:username, :password, :password_confirmation)
  end
end
