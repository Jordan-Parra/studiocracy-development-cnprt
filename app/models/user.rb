class User < ActiveRecord::Base

devise :omniauthable
  
  # Relations
  has_many :posts
  has_many :comments
  has_many :post_votes
  has_many :comment_votes

  has_attached_file :image, styles: { small: "64x64", med: "300x300", large: "500x500" }

  extend FriendlyId
  friendly_id :fullname, use: :slugged


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  # Pagination
  paginates_per 100

  # Validations
  # :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def self.paged(page_number)
    order(admin: :desc, email: :asc).page page_number
  end

  def self.search_and_order(search, page_number)
    if search
      where("email LIKE ?", "%#{search.downcase}%").order(
      admin: :desc, email: :asc
      ).page page_number
    else
      order(admin: :desc, email: :asc).page page_number
    end
  end

  def self.last_signups(count)
    order(created_at: :desc).limit(count).select("id","email","created_at")
  end

  def self.last_signins(count)
    order(last_sign_in_at:
    :desc).limit(count).select("id","email","last_sign_in_at")
  end

  def self.users_count
    where("admin = ? AND locked = ?",false,false).count
  end

  def fullname
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    #user.provider = auth.provider
    #user.uid = auth.uid
    user.first_name = auth.info.first_name
    user.last_name = auth.info.last_name
    user.full_name = auth.info.name
    #user.city =
    #user.state =

    #user.image = auth.info.image
    user.email = auth.info.email
    #user.bio = auth.info.extra.raw_info.bio
    #user.oauth_token = auth.credentials.token
    #user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.password = auth.uid
    user.skip_confirmation!
    user.save!
    end
  end
end
