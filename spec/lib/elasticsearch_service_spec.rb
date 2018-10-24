require 'spec_helper'

describe ElasticsearchService do

  subject { ElasticsearchService.new region: ENV['REGION'] }

  let(:instances) { subject.instances }

  let(:domain_list) { subject.domain_list }

  it { expect(instances.first.domain_id).to be_a String }

  it do
    domain_list.each do |l|
      expect(l).to be_a Array
    end
  end

end

