class Course < ApplicationRecord
  before_create :create_code

  belongs_to :teacher

  validates :code, uniqueness: true

  private

  def create_code
    input = self.name + Time.current.to_s + rand.to_s
    code_hash = Digest::SHA256.hexdigest(input)[0..19]
    self.code = code_hash

    create_code if Course.exists?(code: self.code)
  end
end
