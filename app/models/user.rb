class  User < ApplicationRecord
  before_save :downcase_fields
  has_many :articles, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            length: { maximum: 105 }, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_secure_password

  private

  def downcase_fields
    self.name = name.downcase
    self.email = email.downcase
  end
end
