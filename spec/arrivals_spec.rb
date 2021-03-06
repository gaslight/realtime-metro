require 'metro/arrivals'

RSpec.describe "Arrivals" do
  let(:fixture_file) { File.new("#{__dir__}/fixtures/trip_update") }
  let(:arrivals) { Metro::Arrivals.new(fixture_file.read) }

  describe "#all" do
    it "lists all arrivals" do
      expect(arrivals.all.size).to eq(6370)
    end
  end

  describe "#for_stop" do
    let(:mad_hyd_arrivals) { arrivals.for_stop("MADHYDi") }

    it "lists the stop's arrivals" do
      expect(mad_hyd_arrivals.size).to eq(1)
      expect(mad_hyd_arrivals.first[:route_id]).to eq("11")
      expect(mad_hyd_arrivals.first[:time]).to eq("2015-02-16T18:06:59-05:00")
    end
  end

  describe "parsing stops with arrival times instead of departure times" do
    let(:gsqb_arrivals) { arrivals.for_stop("GSqB") }

    it "provides a time" do
      expect(gsqb_arrivals.first[:time]).to eq("2015-02-16T17:53:00-05:00")
    end
  end
end

