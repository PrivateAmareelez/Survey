DeactivatePollJob = Struct.new(:poll) do
  def perform
    poll.active = false
    poll.save
  end

  def queue_name
    "#{poll.id}_queue"
  end
end
