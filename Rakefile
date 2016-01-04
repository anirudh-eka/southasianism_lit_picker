require 'fileutils'
require 'liquid'

desc "Compile Site - Add watch/w option to watch for changes in sass files and rebuild"
task :compile, [:option] do |t, args|
  option = (args[:option] ? args[:option].downcase : "")

  if option == "watch" || option == "w"
    sh %{ sass --watch stylesheets/:stylesheets/ }
    compile_markdown
  elsif !option.empty?
    raise "#{option} option Invalid"
  else
    sh %{ sass stylesheets/main.sass stylesheets/main.css }
    sh %{ rm stylesheets/*.map }
    compile_markup
  end
end

def compile_markup
  Liquid::Template.file_system = Liquid::LocalFileSystem.new("../anirudh-eka.github.io/_includes")
  nav = File.open("../anirudh-eka.github.io/_includes/navigation.html")
  layout = File.open("templates/layout.html", "r")
  
  sh %{ mkdir templates/temp }
  # compile post markdown into temp html file
  sh %{ pandoc templates/index.markdown -f markdown_strict -t html -o templates/temp/index.html }

  color_picker_info_partials = []

  Dir.foreach("templates/color_picker_info") do |f|
    if (File.extname(f) == ".markdown")
      file_name = File.basename(f, ".markdown")
      sh %{ pandoc templates/color_picker_info/#{file_name}.markdown -f markdown_strict -t html -o templates/temp/#{file_name}.html }

      partial_html = File.open("templates/temp/#{file_name}.html", "r").read
      color_picker_info_partials << [file_name, partial_html]
    end
  end
  

  post_content_as_html = File.open("templates/temp/index.html", "r").read

  index_compiled_html = Liquid::Template.parse(layout.read).render('content' => post_content_as_html, 
                                                                'color_picker_info_partials' => color_picker_info_partials)
  
  index_file = File.open("index.html", "w")
  index_file.puts "<!-- This file is generated when running $ rake compile -->"
  index_file.puts index_compiled_html
  index_file.close

  # clean up temp
  sh %{ rm -rf templates/temp }
end