
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "aws_instance_list/version"

Gem::Specification.new do |spec|
  spec.name          = "aws_instance_list"
  spec.version       = AwsInstanceList::VERSION
  spec.authors       = ["Diego PL"]
  spec.email         = ["diego.piccinini@gmail.com"]

  spec.summary       = %q{Get instance lists of RDS Databases, REDIS  and ElasticSearch for each AWS region}
  spec.description   = %q{The target is get the instance lists of AWS accounts. Return array of data.}
  spec.homepage      = "https://github.com/diegopiccinini/aws_instance_list"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "byebug", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "aws-sdk-rds", "~> 1.23"
  spec.add_dependency "aws-sdk-ec2", "~> 1.37"
  spec.add_dependency "aws-sdk-cloudwatch", "~> 1.6"
  spec.add_dependency "dotenv", "~> 2.5"
end
