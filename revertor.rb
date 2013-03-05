require 'active_support/core_ext'
require 'fileutils'

logger = Logger.new(STDOUT)

file_paths = Dir["translations/**/*.xml"]

file_paths.each do |path|
  file = File.read path
  filename = File.basename path, '.xml'
  directory = File.dirname(path)

  logger.info ("Opening file: #{filename}")

  yaml_content = Hash.from_xml(file)['hash'].to_yaml

  yml_directory = FileUtils.mkdir_p("reverted/#{directory}").first

  File.open "#{yml_directory}/#{filename}.yml", 'w' do |yaml_file|
    yaml_file.write(yaml_content)
  end

  logger.info ("#{filename} converted to YAML")
end
