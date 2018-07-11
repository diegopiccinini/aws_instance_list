require 'aws_instance_list/list'
require 'aws_instance_list/region'
require 'aws_instance_list/metric'
require 'aws_instance_list/rds'
require 'aws_instance_list/version'

require 'dotenv/load'

Dotenv.load

module AwsInstanceList

  DEFAULT_SETTINGS= File.join(%w(spec support default_settings.yaml))

end
