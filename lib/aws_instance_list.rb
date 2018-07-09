require "aws_instance_list/version"
require "aws_instance_list/region"
require "aws_instance_list/rds"
require "aws_instance_list/metric"

require 'dotenv/load'

Dotenv.load

module AwsInstanceList

  DEFAULT_SETTINGS= File.join(%w(spec support default_settings.yaml))

end
