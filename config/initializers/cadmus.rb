Cadmus::Tags::PageUrl.define_page_path_method do |page_name, parent|
  event_page_path(parent, page_name)
end

CadmusFiles.file_model = CmsFile