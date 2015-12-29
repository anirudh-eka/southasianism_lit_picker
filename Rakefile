require 'fileutils'

desc "Compile Site - Add watch/w option to watch for changes and rebuild"
task :compile, [:option] do |t, args|
  option = (args[:option] ? args[:option].downcase : "")

  if option == "watch" || option == "w"
    sh %{ sass --watch stylesheets/:stylesheets/ }
  elsif !option.empty?
    raise "#{option} option Invalid"
  else
    sh %{ sass stylesheets/*.sass stylesheets/main.css }
  end
end