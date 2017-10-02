class User < ApplicationRecord
  has_many :instructions
  validates :nickname, presence: true
  validates :email, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.alphabetical
    self.order('nickname ASC')
  end

  def self.alphabetical_from_z
    self.order('nickname DESC')
  end

  def self.least_recipes
    self.all.sort_by{ |user| user.instructions.count}
  end

  def self.most_recipes
    self.all.sort_by{ |user| user.instructions.count}.reverse
  end

  def self.from_omniauth(auth)
  
    	@user = User.find_or_create_by(uid: auth['uid']) do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.nickname = auth.info.nickname
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protections: true) do |user|
        user.attributes = params
        user.valid?
      end

    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

end

