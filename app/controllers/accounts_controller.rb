class AccountsController < ApplicationController
  def signup # TODO: determine user type.
    @admin = Admin.new
    @teacher = Teacher.new
    @student = Student.new
  end

  def create
    if params[:account_type] == 'student'
      #redirect_to 'students#create'(request.parameters)
      #StudentsController.new.create

    end
  end

  def login
  end
  def logout
  end
end
