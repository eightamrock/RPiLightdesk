  require 'wiringpi'
  
  # Setting LED segment values against wiringpi GPIO inputs. 
  # This will be different depending which GPIO ports you use, mine are randomly plugged in. 
  # These are NOT the wiringpi pin number, they are the GPIO Pin numbers. 
  # Note that the library doesnt support R2 so dont use gpio 21/27 or gpio 25
  # 7 Segment LEDS start at the top and work clockwise
  @segments = {
    a: 4,
    b: 17,
    c: 23,
    d: 18,
    e: 24,
    f: 7,
    g: 22
  }
  
  # figure out which LED segments make up which letters and store them here. 
  @letters = {
    h: [17,23,24,7,22],
    e: [4,18,24,7,22],
    l: [18,24,7],
    o: [23,18,24,22]
  }

  #export your segments 
  @segments.each do |segment, pin| 
    %x(`gpio export #{pin} out`)
    sleep(0.2)
    %x(`gpio -g write #{pin} 1`)
  end

  # Create new pgio object
  @io = WiringPi::GPIO.new(WPI_MODE_SYS)
  
  # turn on all, pass in sleep time between writes
  def allOn (sleepy = 0) 
    @segments.each do |segment, pin|
      @io.write(pin, LOW);
      sleep(sleepy)
    end
  end
  
  #turn all off, pass in sleep time between writes
  def allOff(sleepy = 0)
    @segments.each do |segment, pin|
      @io.write(pin, HIGH)
      sleep(sleepy)
    end
  end
  
  #write a string of letters or numbers (need to add letters that dont exist to the letters array)
  def writeLetter(letter)
    @letters[letter].each do |pin|
      @io.write(pin, LOW)
    end
  end
  
  # cycle some of our methods and see the results
  def cycle
    allOn(0.1)
    allOff(0.1)
 
    "hello".chars.each do |letter|
      writeLetter(letter.to_sym)
      sleep(0.5)
      allOff()
      sleep(0.25)
    end
  end
  
  cycle()

