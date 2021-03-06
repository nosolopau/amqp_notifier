# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{amqp_notifier}
  s.version = "0.0.7b"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pau","TLmaK0"]
  s.date = %q{2011-11-21}
  s.description = %q{AMQP & Qusion helper class}
  s.email = %q{pau@nosolopau.com}
  s.extra_rdoc_files = ["README.rdoc", "lib/amqp_notifier.rb"]
  s.files = ["Manifest", "README.rdoc", "Rakefile", "amqp_notifier.gemspec", "lib/amqp_notifier.rb"]
  s.homepage = %q{http://nosolopau.com}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Amqp_notifier", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{amqp_notifier}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{AMQP & Qusion helper class}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
