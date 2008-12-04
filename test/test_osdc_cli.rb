require File.join(File.dirname(__FILE__), "test_helper.rb")
require 'osdc/cli'

class TestOsdcCli < Test::Unit::TestCase
  context "for 2008 schedule" do
    setup do
      html = File.read(File.dirname(__FILE__) + "/fixtures/paper-2008.html")
      Osdc::CLI.expects(:open).
        with("http://osdc.com.au/2008/papers/index.html").
        returns(html)
      @stdout_io = StringIO.new
    end

    context "with request for list of authors" do
      setup do
        Date.expects(:today).returns(Date.new(2008, 12, 4)).at_least(1)
        Osdc::CLI.execute(@stdout_io, %w[--authors])
        @stdout_io.rewind
        @stdout = @stdout_io.read
      end

      should "print out authors" do
        assert_match(/Pfeiffer, Ferlito/, @stdout)
        assert_match(/Williams/, @stdout)
        assert_match(/Hudson/, @stdout)
      end
    end
    
  end
end