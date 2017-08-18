class Drops::EventDrop < Liquid::Drop
  include Rails.application.routes.url_helpers

  attr_reader :event
  delegate :name, :start_time, :end_time, to: :event

  def initialize(event)
    @event = event
  end

  def url
    event_path(event)
  end
end
