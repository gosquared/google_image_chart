require 'spec_helper'
require 'google_image_chart'

describe GoogleImageChart do
  describe "by default" do
    subject { GoogleImageChart.new }

    its(:type) { should eql "lc" }
    its(:cht) { should eql "lc" }

    its(:width) { should eql 600 }
    its(:height) { should eql 200 }
    its(:chs) { should eql "600x200" }

    its(:margins) { should eql [%w[0 0 0 0]] }
    its(:chma) { should eql "0,0,0,0" }

    its(:axes) { should eql %w[x] }

    its(:legend_position) { should eql "b" }
    its(:chdlp) { should eql "b" }
  end

  describe "line chart" do
    subject do
      GoogleImageChart.new(
        type: "lc:nda",
        axes: %w[x y],
        axes_range: %w[1 0 100 10],
        margins: [%w[10 10 10 10]],
        colours: %w[000000 FF0000],
        line_styles: %w[5 2,5],
        labels: [
          %w[8:00 8:05 8:10 8:15 8:20 8:25 8:30 8:35 8:40 8:45 8:50 8:55 9:00]
        ],
        data: [
          %w[30 20 40 10 30 20 40 50 60 70 90 50 90],
          %w[70 70 70 70 70 70 70 70 70 70 70 70]
        ],
        markers: [
          "N,FF0000,0,9,15",
          "N,FF0000,0,10,15",
          "N,FF0000,0,12,15",
          "v,DDDDDD,0,::1,1,-1"
        ]
      )
    end

    its(:chd) { should eql "t:30,20,40,10,30,20,40,50,60,70,90,50,90|70,70,70,70,70,70,70,70,70,70,70,70" }
    its(:chxl) { should eql "0:|8:00|8:05|8:10|8:15|8:20|8:25|8:30|8:35|8:40|8:45|8:50|8:55|9:00" }
    its(:chxr) { should eql "1,0,100,10" }

    describe "#image_data" do
      it "returns the image content" do
        VCR.use_cassette('google_charts') do
          subject.image_data.should include("PNG")
        end
      end
    end

    describe "#url" do
      it "valid url with all parameters" do
        subject.url.should eql("http://chart.apis.google.com/chart?cht=lc:nda&chs=600x200&chma=10,10,10,10&chco=000000,FF0000&chxt=x,y&chxr=1,0,100,10&chls=5%7C2,5&chxl=0:%7C8:00%7C8:05%7C8:10%7C8:15%7C8:20%7C8:25%7C8:30%7C8:35%7C8:40%7C8:45%7C8:50%7C8:55%7C9:00&chdlp=b&chd=t:30,20,40,10,30,20,40,50,60,70,90,50,90%7C70,70,70,70,70,70,70,70,70,70,70,70&chm=N,FF0000,0,9,15%7CN,FF0000,0,10,15%7CN,FF0000,0,12,15%7Cv,DDDDDD,0,::1,1,-1")
      end
    end
  end

  describe "pie chart" do
    subject do
      GoogleImageChart.new(
        type: "p",
        width: 240,
        height: 157,
        margins: [
          %w[0 0 0 0],
          %w[0 30]
        ],
        colours: %w[308DF3 00FF00 FF0000],
        legend_labels: %w[Group\ A Group\ B Group\ C],
        label_styles: %w[0 67676700 11.167],
        data: [%w[20 10 5]]
      )
    end

    its(:chma) { should eql "0,0,0,0|0,30" }
    its(:chxs) { should eql "0,67676700,11.167" }
    its(:chdl) { should eql "Group A|Group B|Group C" }

    describe "#url" do
      it "valid url with all parameters" do
        subject.url.should eql("http://chart.apis.google.com/chart?cht=p&chs=240x157&chma=0,0,0,0%7C0,30&chco=308DF3,00FF00,FF0000&chxt=x&chxs=0,67676700,11.167&chdl=Group%20A%7CGroup%20B%7CGroup%20C&chdlp=b&chd=t:20,10,5")
      end
    end
  end
end
