require 'spec_helper'

describe Metric do

  subject { Metric.new region: 'eu-central-1' }

  let(:db_instance_identifier) { ENV['DB_INSTANCE_IDENTIFIER'] }

  describe "#statitistics" do

    let(:options) do
      {
        namespace: "AWS/RDS", # required
        metric_name: "FreeStorageSpace", # required
        dimensions: [
          {
            name: "DBInstanceIdentifier", # required
            value: db_instance_identifier, # required
          },
        ],
        start_time: Time.now - 300, # required
        end_time: Time.now , # required
        period: 60, # required
        statistics: ["Minimum"], # accepts SampleCount, Average, Sum, Minimum, Maximum
      }
    end

    let(:statistics) { subject.statistics(options) }

    it { expect(subject.client).to be_a Aws::CloudWatch::Client }

    it { expect(statistics.label).to be_a String }

    it { expect(statistics.datapoints.count).to be > 0 }

  end

  describe "#free_storage_space" do

    it { expect(subject.free_storage_space(db_instance_identifier)).to be_a Float }

  end

  describe "#list" do

    let(:list) { subject.list options }

    let(:options) do
      {
        namespace: "AWS/RDS",
        metric_name: "FreeStorageSpace",
        dimensions: [
          {
            name: "DBInstanceIdentifier", # required
            value: db_instance_identifier, # required
          },
        ],
      }
    end

    it { expect(list.metrics.count).to be > 0 }

  end
end
