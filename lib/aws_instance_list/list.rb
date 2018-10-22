module AwsInstanceList

  class List

    attr_accessor :regions

    def initialize
      @regions=AwsInstanceList::Region.list
      @list={}
    end

    def db_list
      list
    end

    def rds_db_list region:
      rds=AwsInstanceList::RDS.new region: region
      rds.db_list
    end

    def list call_to: :rds_db_list

      threads = []

      regions.each do |region|

        threads << Thread.new do
          @list[region]=self.send( call_to, region: region)
        end

      end

      loop do
        break if threads.count { |th| th.alive? } == 0
      end

      @list.values.flatten(1)

    end

    def cache_list
      list call_to: :cache_instance_list
    end

    def cache_instance_list region:
      ec=AwsInstanceList::ElastiCache.new region: region
      ec.cache_list
    end

  end
end
