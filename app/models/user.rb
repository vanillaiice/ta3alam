class User < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy

  has_many :teachers, dependent: :destroy
  has_many :teaching_classes, through: :teachers, source: :klass

  has_many :students, dependent: :destroy
  has_many :klasses, through: :students, dependent: :destroy

  enum :role, { admin: "admin", owner: "owner", teacher: "teacher", student: "student" }
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, :role, :name, :password, presence: true
end
