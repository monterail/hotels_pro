module RequestHelper
  def fixture(filename)
    fixture_file = File.expand_path(File.join(File.dirname(__FILE__), "fixtures", "#{filename}.json"))
    File.read(fixture_file)
  end
end
