class Task
  def initialize
    @completed = false
  end

  def mark_complete
    @completed = true
  end

  def complete?
    @completed
  end
end
