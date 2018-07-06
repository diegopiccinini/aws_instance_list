require 'spec_helper'

describe RDS do

  let(:db_instances) { subject.db_instances({ max_records: 20}) }

  it { expect(subject.client).to be_a Aws::RDS::Client }

  it { expect(db_instances.count).to eq(20)  }

  it { expect(subject.db_list).to be_a Array }

  #after { puts subject.db_list }

end
