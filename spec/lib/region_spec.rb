require 'spec_helper'

describe AwsInstanceList::Region do

  it { expect(AwsInstanceList::Region.ec2).to be_a Aws::EC2::Client }

end
