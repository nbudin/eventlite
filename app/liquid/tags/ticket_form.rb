module Liquid
  module Tags
    class TicketForm < ::Liquid::Tag
      include Rails.application.routes.url_helpers

      attr_reader :filename

      def render(context)
        begin
          context.registers["controller"].render_to_string(
            partial: 'tickets/form'
          )
        rescue Exception => e
          e.message
        end
      end
    end

    Liquid::Template.register_tag('ticket_form', TicketForm)
  end
end

