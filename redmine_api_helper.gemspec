require_relative 'lib/redmine_api_helper/version'

Gem::Specification.new do |spec|

  spec.name                          = "redmine_api_helper"
  spec.version                       = RedmineAPIHelper::VERSION
  spec.authors                       = ["Stephan Wenzel"]
  spec.email                         = ["stephan.wenzel@drwpatent.de"]
  spec.license                       = 'GPL-2.0'
  
  spec.summary                       = %q{redmine_api_helper aids creating fiddles for redmine_scripting_engine}
  spec.description                   = %q{redmine_api_helper contains methods to ease handling Redmine API calls}
  spec.homepage                      = "https://github.com/HugoHasenbein/redmine_api_helper"
  spec.required_ruby_version         = Gem::Requirement.new(">= 2.3.0")
  
  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  
  spec.metadata["homepage_uri"]      = spec.homepage
  spec.metadata["source_code_uri"]   = "https://github.com/HugoHasenbein/redmine_api_helper"
  spec.metadata["changelog_uri"]     = "https://github.com/HugoHasenbein/redmine_api_helper/Changelog.md"
  
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }.reject{ |f| f.match(%r{\.gem\z})}
  end
  
  spec.bindir                        = "exe"
  spec.executables                   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths                 = ["lib"]
  
  spec.add_runtime_dependency 'deep_try', '~> 0'
  spec.add_runtime_dependency 'fileutils', '~> 0'
  spec.add_runtime_dependency('rubyzip', "~> 1.2.0")
  spec.add_runtime_dependency('nokogiri', ">= 1.5.0")
end
