class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :brands, dependent: :destroy
  has_many :products, dependent: :destroy

  before_create :generate_api_key

  validates :api_key, :email, uniqueness: true

  private

  def generate_api_key
    loop do
      self.api_key = SecureRandom.hex(20)
      break unless User.exists?(api_key: api_key)
    end
  end
end
