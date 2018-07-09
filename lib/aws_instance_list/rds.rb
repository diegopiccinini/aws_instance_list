require 'aws-sdk-rds'
require 'yaml'

module AwsInstanceList

  class RDS

    attr_accessor :client, :region

    def initialize region: 'eu-west-1'

      @region=region

      @client=Aws::RDS::Client.new region: region

      @db_instances = []

    end

    def db_descriptions options={}
      client.describe_db_instances(options)
    end

    def db_instances options={}
      descriptions=db_descriptions(options)
      @db_instances+=descriptions.db_instances
      if descriptions.marker
        options[:marker]=descriptions.marker
        db_instances(options)
      else
        @db_instances
      end
    end

    def db_list fields: nil

      fields||=load_db_fields

      db_instances.map do |i|
        fields.map { |f| i.send(f) } << free_storage_space(i.db_instance_identifier) << region
      end
    end

    def load_db_fields
      yaml['db']['fields']
    end

    def yaml
      @yaml||=yaml_default.merge(yaml_file)[demodulize]
    end

    def yaml_default
      YAML.load_file AwsInstanceList::DEFAULT_SETTINGS
    end

    def yaml_file
      ENV.has_key?('AWS_INSTANCE_LIST_YAML') ? YAML.load_file(ENV['AWS_INSTANCE_LIST_YAML']) : {}
    end

    def demodulize
      self.class.name.split('::').last
    end

    def free_storage_space db_instance_identifier
      metric = Metric.new region: region
      metric.free_storage_space db_instance_identifier
    end

  end

end
