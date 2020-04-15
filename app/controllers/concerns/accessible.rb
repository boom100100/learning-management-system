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
      redirect_to(rails_admin.dashboard_path) and return
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
    current_admin ? true : false
  end
  def teacher?
    current_teacher ? true : false
  end
  def student?
    current_student ? true : false
  end
  def signed_in?
    (admin? || teacher? || student?) ? true : false
  end
end
