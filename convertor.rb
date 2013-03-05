require 'active_support/core_ext'
require 'fileutils'

file_paths = Dir["config/locales/**/*.yml"]

file_paths.each do |path|
  file = File.read path
  filename = File.basename path, '.yml'
  directory = File.dirname(path)

  xml_content = YAML.parse(file).transform.to_xml
  xml_directory = FileUtils.mkdir_p("translations/#{directory}").first

  File.open "#{xml_directory}/#{filename}.xml", 'w' do |xml_file|
    xml_file.write(xml_content)
  end
end
