require 'digest/sha2'
class User < ActiveRecord::Base
   has_attached_file :media,
       :styles => {
       :thumb=> "100x100#",
       :small  => "400x400>" },  
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "/images/:id/:style.:extension",
    :url => ":s3_domain_url"
 attr_accessible :name, :password, :password_confirmation, :role1, :Email_id, :media
 has_attached_file :media
  validates :name, :presence => true, :uniqueness => true
    after_create :send_mail
  
  def send_mail
   Notifier.new_user_created(self).deliver 
   p 1111111111111111111111111111
      RegistrationConfirmed.registration_confirmed(self).deliver    
  end

  
  validates :password, :confirmation => true
  attr_accessor :password_confirmation 
  attr_reader   :password

  validate  :password_must_be_present
  def current
   User.find_by_id(session[:user_id])
   end 
  
 

  def self.create_with_omniauth(omniauth)
  create! do |user|
        if auth['info']
      user.name = auth['info']['name'] || ""
      user.email = auth['info']['email'] || ""
     end
    end
   end
   
     
  class << self
  
   
   def authenticate(name, password)
    if user = find_by_name(name)
      if user.hashed_password == encrypt_password(password, user.salt)
       user
      end
    end
  end
 
  def encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "wibble" + salt)
  end
 end
   
 def password=(password)
   @password =   password
   
   if password.present?
    generate_salt
    self.hashed_password = self.class.encrypt_password(password, salt)
  end
end
  
  private
 
 def password_must_be_present
  errors.add(:password, "missing password")unless hashed_password.present?
 end
 

 
 def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
   end
   
    
 end
