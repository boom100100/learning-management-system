module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

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

  def direct?(user)
    unless user
      redirect_back(fallback_location: root_path)
      return false
    end
    true
  end

  def admin?
    current_admin
  end
  def teacher?
    current_teacher
  end
  def student?
    current_teacher
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
end
