# frozen_string_literal: true

require_relative "lib/yabeda/schked/version"

Gem::Specification.new do |spec|
  spec.name = "yabeda-schked"
  spec.version = Yabeda::Schked::VERSION
  spec.authors = ["Svyatoslav Kryukov"]
  spec.email = ["s.g.kryukov@yandex.ru"]

  spec.summary = "Export performance metrics for Schked"
  spec.description = <<~DESC
    Yabeda plugin for easy collecting Schked metrics: number of executed jobs and job runtime.
  DESC
  spec.homepage = "https://github.com/yabeda-rb/yabeda-schked"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/yabeda-rb/yabeda-schked"
  spec.metadata["changelog_uri"] = "https://github.com/yabeda-rb/yabeda-schked/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.4.0"

  spec.add_dependency "yabeda", "~> 0.8"
  spec.add_dependency "schked", ">= 0.3", "< 2"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "standard", "~> 1.0"
  spec.add_development_dependency "rubocop-md", "~> 1.0"
end
