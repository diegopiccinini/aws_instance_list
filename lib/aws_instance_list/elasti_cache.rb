require 'aws-sdk-elasticache'

module AwsInstanceList

  class ElastiCache < AwsInstanceList::Base

    def initialize region: 'eu-west-1'

      super region: region

      @client=Aws::ElastiCache::Client.new region: region

    end

    def list_method
      :cache_clusters
    end

    def descriptions options={}
      client.describe_cache_clusters(options)
    end

    def bytes_used_for_cache cache_cluster_id
      metric.bytes_used_for_cache cache_cluster_id
    end
  end
end


