require 'spec_helper'

describe List do

  before do
    allow(AwsInstanceList::Region).to receive(:list).and_return( %w(region1 region2) )
    allow(subject).to receive(:rds_db_list).with(region: 'region1').and_return( ('aa'..'bz').to_a )
    allow(subject).to receive(:rds_db_list).with(region: 'region2').and_return( ('ca'..'cz').to_a )
  end

  it { expect(subject.regions.count).to be == 2 }

  it { expect(subject.rds_db_list(region: 'region1').count).to be == 52 }

  it { expect(subject.db_list).to match_array ('aa'..'cz').to_a }


end
