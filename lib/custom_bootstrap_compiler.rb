class CustomBootstrapCompiler
  attr_reader :variables

  def initialize(variables)
    @variables = variables
  end

  def variables_digest
    @variables_digest ||= Digest::SHA1.hexdigest(JSON.dump(variables))
  end

  def logical_file_name
    "bootstrap-custom-#{variables_digest}.css"
  end

  def base_path
    File.expand_path("tmp/bootstrap-custom", Rails.root)
  end

  def file_path
    @file_path ||= File.expand_path("#{base_path}/bootstrap-custom-#{variables_digest}.scss", Rails.root)
  end

  def sprockets_env
    @sprockets_env ||= begin
      if Rails.application.assets.is_a?(Sprockets::Index)
        Rails.application.assets.instance_variable_get('@environment')
      else
        Rails.application.assets
      end
    end
  end

  def scss
    variables_scss = variables.map do |name, value|
      "$#{name}: #{value};"
    end.join('\n')

    <<-SCSS
    #{variables_scss}
    @import "bootstrap";
    @import "font-awesome";
    SCSS
  end

  def write_scss
    FileUtils.mkdir_p base_path

    File.open(file_path, 'w') do |file|
      file.write(scss)
    end
  end

  def compile
    write_scss unless File.exist?(file_path)
    sprockets_env.find_asset(logical_file_name).source
  end
end