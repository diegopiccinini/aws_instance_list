require 'aws-sdk-ec2'

module AwsInstanceList

  class Region

    class << self

      def ec2
        @ec2||=Aws::EC2::Client.new
      end

      def descriptions
        @descriptions||=ec2.describe_regions
      end

      def list
        descriptions.regions.map do |description|
          description.region_name
        end
      end

    end

  end
end
