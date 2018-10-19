require 'spec_helper'

DbInstance=Struct.new( :db_instance_identifier, :engine, :allocated_storage, :db_instance_status)
Description=Struct.new( :db_instances, :marker)

describe RDS do

  let(:options) { { max_records: 20 } }

  let(:client) { instance_double(Aws::RDS::Client) }

  describe "#new" do

    subject { RDS.new region: ENV['REGION'] }

    it { expect(subject.client).to be_a Aws::RDS::Client }

  end

  describe "#db_list" do

    before do

      # comment this before to test calling AWS services in your ENV['REGION']

      allow(client).to receive(:describe_db_instances).with(options).and_return(descriptions)

      allow(subject).to receive(:client).and_return(client)

      descriptions.db_instances.each do |i|

        allow(subject).to receive(:free_storage_space).with(i.db_instance_identifier).and_return(i.allocated_storage * rand )

      end

    end



    context "without pagination" do

      subject { RDS.new region: ENV['REGION'] }

      let(:descriptions) do

        instances = 10.times.map do |i|
          DbInstance.new( "db_#{i}", 'mysql', rand(100), 'available')
        end

        Description.new( instances, nil)
      end

      let(:instances) { subject.instances(options) }

      let(:db_list) { subject.db_list(options: options) }

      let(:one_db_list_element) { db_list.last }


      it { expect(instances.count).to be == 10 }

      it { expect(subject.descriptions(options).marker).to be_nil }

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

      let(:second_options) { { max_records: 20, marker: 'SecondOptions' } }

      before do

        allow(client).to receive(:describe_db_instances).with(second_options).and_return(second_descriptions)

      end

      let(:descriptions) do

        insts = 20.times.map do |i|
          DbInstance.new( "db_#{i}", 'mysql', rand(100), 'available')
        end

        Description.new( insts, 'SecondOptions')

      end

      let(:second_descriptions) do

        insts = 20.upto(34).map do |i|
          DbInstance.new( "db_#{i}", 'mysql', rand(100), 'available')
        end

        Description.new( insts, nil)

      end

      it { expect(subject.descriptions(options).marker).to be_a String }

      it { expect(subject.instances(options).count).to be > 20 }

    end

  end

end
