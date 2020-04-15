class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #has_secure_password
  validates :email, uniqueness: { case_sensitive: false, message: 'This username is already taken.' }
  validates :password, confirmation: true

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        session[:type] = 'admin'
      end
    end
  end

  def self.from_omniauth(auth)
    user = Admin.find_by('email = ?', auth['info']['email'])
    if user.blank?
       user = Admin.new(
         {
          provider: auth.provider,
          uid: auth.uid,
          email: auth.info.email,
          password: Devise.friendly_token[0,20]
         }
       )
       user.save!
    end
    user
  end
end
