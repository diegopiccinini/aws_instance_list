require 'spec_helper'

describe List do

  before do
    allow(AwsInstanceList::Region).to receive(:list).and_return( %w(region1 region2) )
    allow(AwsInstanceList::RDS).to receive(:db_instances)
    allow(AwsInstanceList::RDS).to receive(:new)
    allow(AwsInstanceList::RDS).to receive(:db_list).and_return( ['aa'.. 'zb'].to_a )
  end

  it { expect(subject.regions.count).to be == 2 }

  it { expect(subject.db_list.count).to be == 61 }


end
