require 'optparse'
require "open-uri"
require "hpricot"

module Osdc
  class CLI
    def self.execute(stdout, arguments=[])
      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
          Usage: #{File.basename($0)} [options]

          Options are:
        BANNER
        opts.separator ""
        opts.on("-a", "--authors",
                "Show list of authors.") { |arg| @today = arg }
        opts.on("-h", "--help",
                "Show this help message.") { stdout.puts opts; exit }
        opts.parse!(arguments)
      end

      @doc = Hpricot(open("http://osdc.com.au/#{Date.today.year}/papers/index.html"))
      if @today
        stdout.puts @doc.search("table td i").map { |item| item.inner_html }.reject { |i| i.strip.empty? }.sort
      end
    end
  end
end