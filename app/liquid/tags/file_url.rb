module Liquid
  module Tags
    class FileUrl < ::Liquid::Tag
      include Rails.application.routes.url_helpers

      attr_reader :filename

      def initialize(tag_name, args, tokens)
        super
        @filename = args.strip.gsub(/\A([\"\'])(.*)\1\z/, '\2')
      end

      def render(context)
        parent = context.registers['parent']
        unless parent
          return "Error: file_url called without any parent object in the context"
        end

        cms_file = CmsFile.find_by(parent: parent, file: filename)
        unless cms_file
          return "Error: file #{filename} not found"
        end

        cms_file.file.url
      end
    end

    Liquid::Template.register_tag('file_url', FileUrl)
  end
end

