require 'spec_helper'

describe RDS do


  subject { RDS.new region: ENV['REGION'] }

  let(:db_instances) { subject.db_instances({ max_records: 20}) }

  let(:db_list) { subject.db_list }

  let(:one_db_list_element) { db_list.last }

  it { expect(subject.client).to be_a Aws::RDS::Client }

  it { expect(db_instances.count).to be > 0 }

  it { expect(db_list).to be_a Array }

  it { expect(one_db_list_element.last). to be == subject.region }

  it { expect(one_db_list_element[-2]). to be_a Float }

#  after { puts subject.db_list }

  describe "#free_storage_space" do

    let(:db_name) { ENV['DB_INSTANCE_IDENTIFIER'] }

    it { expect(subject.free_storage_space(db_name)).to be_a Float }

  end

end
