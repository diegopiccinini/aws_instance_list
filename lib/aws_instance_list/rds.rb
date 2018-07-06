require 'aws-sdk-rds'

module AwsInstanceList

  class RDS
    attr_accessor :client

    def initialize
      @client=Aws::RDS::Client.new
    end
  end

end
