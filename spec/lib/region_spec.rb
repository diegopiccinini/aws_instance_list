require 'spec_helper'

describe Region do

  it { expect(Region.ec2).to be_a Aws::EC2::Client }

  it { expect(Region.descriptions.regions).to be_a Array }

  it { expect(Region.list).to include 'eu-west-1' }

end
