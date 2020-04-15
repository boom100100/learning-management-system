class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #has_secure_password
  has_many :courses
  has_many :students, through: :courses

  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    #user = Teacher.find_by('email = ?', auth['info']['email'])
    where(email: auth.info.email).first_or_initialize.tap do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      #user.full_name = auth.info.name
      #user.profile_image = auth.info.image
      user.save
    end
  end
end
