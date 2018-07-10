require 'spec_helper'

DbInstance=Struct.new( :db_instance_identifier, :engine, :allocated_storage, :db_instance_status)
Description=Struct.new( :db_instances, :marker)

describe RDS do

  let(:options) { { max_records: 20 } }

  describe "#new" do

    subject { RDS.new region: ENV['REGION'] }

    it { expect(subject.client).to be_a Aws::RDS::Client }

  end

  context "without pagination" do

    subject { RDS.new region: ENV['REGION'] }

    before do

      # comment this before to test calling AWS services in your ENV['REGION']

      client=instance_double(Aws::RDS::Client)

      allow(client).to receive(:describe_db_instances).with(options).and_return(descriptions)

      allow(subject).to receive(:client).and_return(client)

      descriptions.db_instances.each do |i|

        allow(subject).to receive(:free_storage_space).with(i.db_instance_identifier).and_return(i.allocated_storage * rand )

      end

    end

    let(:descriptions) do

      instances = 10.times.map do |i|
        DbInstance.new( "db_#{i}", 'mysql', rand(100), 'available')
      end

      Description.new( instances, nil)
    end


    let(:db_instances) { subject.db_instances(options) }

    let(:db_list) { subject.db_list(options: options) }

    let(:one_db_list_element) { db_list.last }


    it { expect(db_instances.count).to be == 10 }

    it { expect(subject.db_descriptions(options).marker).to be_nil }

    it { expect(db_list).to be_a Array }

    it { expect(one_db_list_element.last). to be == subject.region }

    it { expect(one_db_list_element[-2]). to be_a Float }

    describe "#free_storage_space" do

      let(:db_name) { 'db_9' }

      it { expect(subject.free_storage_space(db_name)).to be_a Float }

    end

  end

  context "with pagination" do

    subject { RDS.new region: ENV['LONG_REGION'] }

    it { expect(subject.db_descriptions(options).marker).to be_a String }

    it { expect(subject.db_instances(options).count).to be > 20 }

  end

end
