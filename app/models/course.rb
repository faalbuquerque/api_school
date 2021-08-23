class Course < ApplicationRecord
  belongs_to :teacher

  def create_code
    input = self.name + Time.current.to_s + rand.to_s
    @code_hash = Digest::SHA256.hexdigest(input)[0..19]
    self.code = @code_hash
  end
end
