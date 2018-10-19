require 'spec_helper'

describe ElastiCache do

  subject { ElastiCache.new region: ENV['REGION'] }

  let(:clusters) { subject.descriptions.cache_clusters }

  it { expect(clusters).to be_a Array }

  it { expect(subject.instances( { max_records: 20 }).first.cache_cluster_id).to be_a String }

end

