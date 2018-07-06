require 'aws-sdk-rds'

module AwsInstanceList

  class RDS

    attr_accessor :client, :region

    def initialize region: 'eu-west-1'

      @region=region

      @client=Aws::RDS::Client.new region: region

    end

    def db_descriptions options={}
      @db_descriptions||=client.describe_db_instances(options)
    end

    def db_instances options={}
      @db_intances||=db_descriptions(options).db_instances
    end

    def db_list fields=[:db_name,:engine,:allocated_storage, :db_instance_status]
      db_instances.map do |i|
        fields.map { |f| i.send(f) } << region
      end
    end

  end

end
