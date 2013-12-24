class User < ActiveRecord::Base
  USER_TYPES = ['Master', 'PhD', 'Lector']

  attr_accessor :password, :password_confirmation
  
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :first_name, :last_name, :presence => true
  validates :user_type, :inclusion => { :in => USER_TYPES }
  validates :password, :presence => true, :on => :create
  validates :password, :length => { :minimum => 6 }, :if => lambda { |record| record.password.present? }
  validates :password, :confirmation => true, :if => lambda { |record| record.password.present? }

  def self.authenticate(email, password)
    find_by(:email => email, :password_digest => Digest::SHA512.hexdigest(password))
  end

  def password=(value)
    self.password_digest = Digest::SHA512.hexdigest(value)
    @password = value
  end

end
