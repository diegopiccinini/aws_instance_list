require 'aws-sdk-ec2'

module AwsInstanceList

  class Region

    class << self

      def ec2
        @ec2||=Aws::EC2::Client.new
      end

    end

  end
end
