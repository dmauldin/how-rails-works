require 'rubygems'
require 'erb'
require 'RedCloth'
require 'uv'

Dir["*.textile"].each do |file|
  puts "Generating file for #{file}"
  content = File.readlines(file).to_s
  content = RedCloth.new(content).to_html
  content.gsub!(/<pre type='(.*?)'>(.*?)<\/pre>/mis) { Uv.parse($2.strip, "xhtml", $1, true, "sunburst") }
  output = ERB::new(File.readlines("layout.erb").to_s).result(binding)

  File.open("doc/#{file.gsub("textile", "html")}", "w+").write(output)
end