# Mock class to mimic a rails env.
class Rails

  def self.env
    self
  end

  def self.production?
    true
  end

end
