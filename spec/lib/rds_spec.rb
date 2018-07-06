require 'spec_helper'

describe RDS do

  it { expect(subject.client).to be_a Aws::RDS::Client }

  it { expect(subject.db_instances).to be_a Array }

end
