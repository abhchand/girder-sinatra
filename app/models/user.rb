class User < ActiveRecord::Base
  validates :name, presence: true
  validates :password, presence: true

  before_validation :canonicalize_name

  private

  def canonicalize_name
    name.downcase! if name
  end
end
