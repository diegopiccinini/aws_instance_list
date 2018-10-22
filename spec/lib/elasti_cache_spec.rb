require 'spec_helper'

describe ElastiCache do

  subject { ElastiCache.new region: ENV['REGION'] }

  let(:clusters) { subject.descriptions.cache_clusters }

  let(:options) { { max_records: 20 } }

  let(:instances) { subject.instances(options) }

  let(:cache_list) { subject.cache_list( options: options ) }

  it { expect(clusters).to be_a Array }

  it { expect(instances.first.cache_cluster_id).to be_a String }

  it do
    cache_list.each do |l|
      expect(l[-2]).to be > 0
    end
  end

end

