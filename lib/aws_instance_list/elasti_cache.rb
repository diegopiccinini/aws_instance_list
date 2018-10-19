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

    def freeable_memory cache_cluster_id
      metric.freeable_memory cache_cluster_id
    end

    def cache_list options: {}, fields: nil

      fields||=load_cache_fields

      instances(options).map do |i|
        fields.map { |f| i.send(f) } + metrics(i.cache_cluster_id) << region
      end
    end

    def load_cache_fields
      yaml['cache']['fields']
    end

    def metrics cache_cluster_id
      used=bytes_used_for_cache(cache_cluster_id)
      free=freeable_memory(cache_cluster_id)
      total=free + used
      [used, total, used / total * 100.0]
    end
  end
end


