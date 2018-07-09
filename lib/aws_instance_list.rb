Dir.glob(File.join('lib','aws_instance_list','*.rb')).each { |file| require file[4..-4] }

require 'dotenv/load'

Dotenv.load

module AwsInstanceList

  DEFAULT_SETTINGS= File.join(%w(spec support default_settings.yaml))

end
