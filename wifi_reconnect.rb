require 'open-uri'
require 'io/console'

class InternetConnection
  attr_accessor :ssid
  attr_accessor :password

  def initialize(ssid, password)
    self.ssid = ssid
    self.password = password
  end

  def internet_connection?
    begin
      true if open("http://www.google.com/")
    rescue
      false
    end
  end

  def connect_to_internet
    `networksetup -setairportpower en0 off`
    `networksetup -setairportpower en0 on`
    `networksetup -setairportnetwork en0 '#{ssid}' '#{password}'`
  end

  def log
    puts "#{Time.now.strftime("%Y%m%d%H%M%S")} Connection was reset."
  end

  def check_for_internet
    loop do
      unless internet_connection?
        connect_to_internet
        log
      end
      sleep(300)
    end
  end
end

puts "========================="
puts "Automatic WiFi Connection"
puts "***** CTR C to Quit *****"
puts "=========================\n\n"
puts "What is your SSID? (WiFi Name)"

ssid = gets

puts "What is your WiFi password?"

password = STDIN.noecho(&:gets)

puts "Now connecting to #{ssid}"

connection = InternetConnection.new(ssid, password)
connection.check_for_internet