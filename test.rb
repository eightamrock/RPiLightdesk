

  require 'wiringpi'
  
  # Setting LED segment values against wiringpi GPIO inputs. 
  # This will be different depending which GPIO ports you use, mine are randomly plugged in. 
  @segments = {
    a: 7,
    b: 0,
    c: 4,
    d: 1,
    e: 5,
    f: 2,
    g: 3
  }

  # Create new pgio object
  io = WiringPi::GPIO.new(WPI_MODE_SYS)
  @segments.each do |segment, port|
    puts "Setting Mode for #{segment}\n"
    io.mode(port,OUTPUT)
    puts "Turning on #{port}\n"
    io.write(port, 0)
    sleep(1)
    puts "Turning off #{port}\n"
    io.write(port, 1)
  end


