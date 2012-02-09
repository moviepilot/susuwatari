require 'spec_helper'

describe Susuwatari do
  let(:key){ "4dabc19c6d0a4c30a2a20b4a6448d085" }
  let(:url){ "google.com"}

  context 'run a simple test' do
    specify do
      stub_request(:get, "http://www.webpagetest.org/runtest.php?f=json&k=#{key}&runs=1&url=#{url}").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :headers => {}, :body =>
                  { "statusCode" => 200,
                    "statusText" => "Ok",
                    "data" => {
                      "testId"     => "120116_KP_2WMG1",
                      "ownerKey"   => "4dabc19c6d0a4c30a2a20b4a6448d085",
                      "jsonUrl"    => "http://www.webpagetest.org/results.php?test=120116_KP_2WMG1&f=json",
                      "xmlUrl"     => "http://www.webpagetest.org/xmlResult\/120116_KP_2WMG1/",
                      "userUrl"    => "http://www.webpagetest.org/result\/120116_KP_2WMG1/",
                      "summaryCSV" => "http://www.webpagetest.org/result\/120116_KP_2WMG1/page_data.csv",
                      "detailCSV"  => "http://www.webpagetest.org/result\/120116_KP_2WMG1/requests.csv" } }.to_json)
      mei = Susuwatari.new( url: 'google.com', k: key )
      mei.run
    end

    it "raises an error if the request could not be completed" do
      url = "trollololo"
      status_text = "Please enter a Valid URL.  <b>trollololo</b> is not a valid Internet host name"
      stub_request(:get, "http://www.webpagetest.org/runtest.php?f=json&k=#{key}&runs=1&url=#{url}").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :headers => {}, :body =>
                  { "statusCode"=>400,
                    "statusText"=>
                    status_text }.to_json )
      mei = Susuwatari.new( url: url, k: key )
      lambda{ mei.run }.should raise_error(Susuwatari::Error, status_text)
    end
  end
end
