
module AwsInstanceList

  class List

    attr_accessor :regions

    def initialize
      @regions=AwsInstanceList::Region.list
      @db_list={}
    end

    def db_list

      if @db_list.empty?

        threads = []

        regions.each do |region|

          threads << Thread.new do
            @db_list[region]=rds_db_list region: region
          end

        end

        loop do
          sleep 5
          break if threads.count { |th| th.alive? } == 0
        end

      end

      @db_list.values.flatten(1)

    end

    def rds_db_list region:
      rds=AwsInstanceList::RDS.new region: region
      rds.db_instances
      rds.db_list
    end

  end
end
