require 'spec_helper'

describe ElastiCache do

  subject { ElastiCache.new region: ENV['REGION'] }

  it { expect(subject.descriptions.cache_clusters).to be_a Array }

end

