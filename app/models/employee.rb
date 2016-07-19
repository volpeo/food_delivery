class Employee
  attr_accessor :id
  attr_reader :login, :password, :job
  def initialize(attributes)
    @id = attributes[:id].to_i
    @login = attributes[:login]
    @password = attributes[:password]
    @job = attributes[:job].to_sym || :delivery_guy
  end

  def manager?
    @job == :manager
  end

  def delivery_guy?
    @job == :delivery_guy
  end
end