
module AwsInstanceList

  class List

    attr_accessor :regions

    def initialize
      @regions=AwsInstanceList::Region.list
    end

  end
end
