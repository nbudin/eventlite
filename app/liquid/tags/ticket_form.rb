module Liquid
  module Tags
    class TicketForm < ::Liquid::Tag
      include Rails.application.routes.url_helpers

      attr_reader :filename, :after_sale_url, :after_sale_page

      def initialize(_tag_name, args_string, _options)
        super

        @errors = []
        parsed_args = parse_args_string(args_string)

        @errors << 'Must specify either after_sale_url or after_sale_page a required parameter' unless parsed_args['after_sale_url'] || parsed_args['after_sale_page']
        unknown_args = parsed_args.keys - ['after_sale_url', 'after_sale_page']
        @errors << "Unknown parameters: #{unknown_args.join(', ')}" if unknown_args.any?

        @after_sale_url = parsed_args['after_sale_url']
        @after_sale_page = parsed_args['after_sale_page']
      end

      def render(context)
        return "Error: #{@errors.join(', ')}" if @errors.any?

        controller = context.registers['controller']

        begin
          controller.render_to_string(
            partial: 'tickets/form',
            locals: { after_sale_url: effective_after_sale_url(controller, context.registers['parent']) }
          )
        rescue Exception => e
          e.message
        end
      end

      private

      def parse_args_string(args_string)
        raw_args = args_string.split(/\s+/)
        raw_args.each_with_object({}) do |raw_arg, parsed_args|
          if match = /\A(\w+):(.*)\z/.match(raw_arg)
            key, value = match[1], match[2]
            parsed_args[key] = value
          else
            @errors << "Unparseable parameter: #{raw_arg}"
          end
        end
      end

      def effective_after_sale_url(controller, parent)
        after_sale_url || controller.event_page_path(parent, after_sale_page)
      end
    end

    Liquid::Template.register_tag('ticket_form', TicketForm)
  end
end

