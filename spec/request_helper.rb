module RequestHelper
  def stub_url(url, response)
    @hydra ||= Typhoeus::Hydra.hydra
    @hydra.stub(:get, url).and_return(response)
  end

  def stub_response(fixture)
    fixture_file = File.expand_path(File.join(File.dirname(__FILE__), "fixtures", "#{fixture}.json"))

    Typhoeus::Response.new(
      :code => 200,
      :headers => "",
      :time => 0.1,
      :body => File.read(fixture_file),
    )
  end
end