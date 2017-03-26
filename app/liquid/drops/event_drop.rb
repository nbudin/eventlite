class Drops::EventDrop < Liquid::Drop
  attr_reader :event
  delegate :name, :start_time, :end_time, to: :event

  def initialize(event)
    @event = event
  end
end