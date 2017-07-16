Cadmus::Tags::PageUrl.define_page_path_method do |page_name, parent|
  event_page_path(parent, page_name)
end

Cadmus.page_model = Page
Cadmus.layout_model = CmsLayout
CadmusFiles.file_model = CmsFile
CadmusNavbar.navigation_item_model = NavigationItem