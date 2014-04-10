begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "MortisCMS"
    gem.summary = "CMS for Rails 4"
    gem.files = Dir["{lib}/**/*", "{app}/**/*", "{config}/**/*"]
		gem.version = "0.1.20"
    gem.authors = ["Brendan Ragan"]
    # other fields that would normally go in your gemspec
    # like authors, email and has_rdoc can also be included here
    gem.add_dependency 'paperclip', "~> 4.1"
    gem.add_dependency 'paperclip-meta'
    gem.add_dependency 'RedCloth'
    gem.add_dependency 'haml-rails'
  end
rescue
  puts "Jeweler or one of its dependencies is not installed."
end
