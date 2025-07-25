class User < ApplicationRecord
    has_secure_password

    # Associations
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy

    # Validations
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :role, presence: true, inclusion: { in: %w[user admin] }
end
