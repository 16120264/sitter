class User < ActiveRecord::Base
  has_many :bookings
  enum role: [:client, :sitter, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :client
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
