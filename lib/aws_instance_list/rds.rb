require 'aws-sdk-rds'

module AwsInstanceList

  class RDS
    attr_accessor :client

    def initialize
      @client=Aws::RDS::Client.new
    end

    def db_descriptions
      @db_descriptions||=client.describe_db_instances
    end

    def db_instances
      db_descriptions.db_instances
    end

  end

end
