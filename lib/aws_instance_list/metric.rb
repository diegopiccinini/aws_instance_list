require 'aws-sdk-cloudwatch'

module AwsInstanceList

  class Metric

    attr_accessor :client

    def initialize region: 'eu-west-1'
      @client=Aws::CloudWatch::Client.new region: region
    end

    def statistics options
      client.get_metric_statistics options
    end

    def list options
      client.list_metrics options
    end

    def free_storage_space identifier, namespace: 'AWS/RDS', dimension_name: 'DBInstanceIdentifier'
      resp=statistics( {
        namespace: namespace,
        metric_name: "FreeStorageSpace",
        dimensions: [
          {
            name: dimension_name,
            value: identifier,
          },
        ],
        start_time: Time.now - 600,
        end_time: Time.now ,
        period: 60,
        statistics: ["Minimum"]
      })

      if resp.datapoints.empty?
        '-'
      else
        resp.datapoints.last.minimum / ( 1024.0 ** 3)
      end

    end

    def bytes_used_for_cache cache_cluster_id
      resp=statistics( {
        namespace: "AWS/ElastiCache",
        metric_name: "BytesUsedForCache",
        dimensions: [
          {
            name: "CacheClusterId",
            value: cache_cluster_id,
          },
        ],
        start_time: Time.now - 600,
        end_time: Time.now ,
        period: 60,
        statistics: ["Maximum"]
      })

      resp.datapoints.last.maximum

    end


    def freeable_memory cache_cluster_id
      resp=statistics( {
        namespace: "AWS/ElastiCache",
        metric_name: "FreeableMemory",
        dimensions: [
          {
            name: "CacheClusterId",
            value: cache_cluster_id,
          },
        ],
        start_time: Time.now - 600,
        end_time: Time.now ,
        period: 60,
        statistics: ["Maximum"]
      })

      resp.datapoints.last.maximum

    end

    def es_free_storage_space domain_name
      free_storage_space domain_name, namespace: 'AWS/ES', dimension_name: 'DomainName'
    end

  end
end

