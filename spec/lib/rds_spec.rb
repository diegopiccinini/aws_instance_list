require 'spec_helper'

describe RDS do
  it { expect(subject.client).to be_a Aws::RDS::Client }
end
