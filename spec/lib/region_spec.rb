require 'spec_helper'

describe AwsInstanceList::Region do

  it { expect(AwsInstanceList::Region.ec2).to be_a Aws::EC2::Client }

  it { expect(AwsInstanceList::Region.descriptions.regions).to be_a Array }

  it { expect(AwsInstanceList::Region.list).to include 'eu-west-1' }

end
