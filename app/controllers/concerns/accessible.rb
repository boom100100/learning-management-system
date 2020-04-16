module Accessible
  extend ActiveSupport::Concern

  protected
  def check_user
    if current_admin
      flash.clear
      # if you have rails_admin. You can redirect anywhere really
      redirect_to(current_admin) and return
    elsif current_teacher
      flash.clear
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to current_teacher and return
    elsif current_student
      flash.clear
      redirect_to current_student and return
    end
  end

  def admin?
    current_admin
  end
  def teacher?
    current_teacher
  end
  def student?
    current_student
  end
  def signed_in?
    (admin? || teacher? || student?) ? true : false
  end

  def visitor_is_self?
    uri_val = request.original_fullpath.split('/')

    if admin?
      return (uri_val[1] == 'admins' && current_admin.id == uri_val[2].to_i)
    elsif teacher?
      return (uri_val[1] == 'teachers' && current_teacher.id == uri_val[2].to_i)
    elsif student?
      return (uri_val[1] == 'students' && current_student.id == uri_val[2].to_i)
    end
  end

  def visitor_self_or_admin?
    visitor_is_self? || admin?
  end

  def visitor_teacher_or_admin?
    teacher? || admin?
  end

  def authorize_teacher_or_admin
    unless visitor_teacher_or_admin?
      direct_unauthorized
    end
  end

  def authorize_self_or_admin
    unless visitor_self_or_admin?
      direct_unauthorized
    end
  end

  def authorize_admin
    unless current_admin
      direct_unauthorized
    end
  end

  def authorize_user
    unless signed_in?
      direct_unauthorized
    end
  end

  def direct_unauthorized
    flash[:error] = "#{request.original_url} not found."
    redirect_back(fallback_location: "/") # halts request cycle
  end
end
