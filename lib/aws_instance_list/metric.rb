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

    def free_storage_space db_instance_identifier
      resp=statistics( {
        namespace: "AWS/RDS",
        metric_name: "FreeStorageSpace",
        dimensions: [
          {
            name: "DBInstanceIdentifier",
            value: db_instance_identifier,
          },
        ],
        start_time: Time.now - 600,
        end_time: Time.now ,
        period: 60,
        statistics: ["Minimum"]
      })

      resp.datapoints.last.minimum / ( 1024.0 ** 3)

    end

  end
end

