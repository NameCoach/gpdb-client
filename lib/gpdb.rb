module Gpdb
  def self.configuration
    Configuration.instance
  end

  def self.configure
    yield configuration
  end
end
