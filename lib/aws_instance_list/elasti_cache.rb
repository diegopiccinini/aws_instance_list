require 'aws-sdk-elasticache'
require 'yaml'

module AwsInstanceList

  class ElastiCache

    attr_accessor :client, :region

    def initialize region: 'eu-west-1'

      @region=region

      @client=Aws::ElastiCache::Client.new region: region
      @instances=[]

    end

    def descriptions options={}
      client.describe_cache_clusters(options)
    end

  end
end


