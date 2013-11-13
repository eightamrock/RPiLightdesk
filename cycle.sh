#!/bin/bash

# declare your pins
declare -a pins=(7 0 4 1 5 11 3)
declare -a arrayh=(0 4 5 11 3)
declare -a arraye=(7 1 5 11 3)
declare -a arrayl=(1 5 11)
declare -a arrayo=(4 1 5 3)
declare -a hello=(h e l l o)

#cycle to reset
for pin in ${pins[@]}
do
  echo "Setting pin ${pin} mode to output"
  gpio mode ${pin} out
  echo "Turning on LED for pin ${pin}"
  gpio write ${pin} 0
  echo "Sleeping for 1 second"
  sleep .025 
  echo "Turning off LED for pin ${pin}"
  gpio write ${pin} 1
done

# Loop on
for pin in ${pins[@]}
do  
  echo "Turning on LED for pin ${pin}"
  gpio write ${pin} 0
  echo "Sleeping for 1 second"
  sleep .05
done

#Loop off
for pin in ${pins[@]}
do
  echo "Turning off LED for pin ${pin}"
  gpio write ${pin} 1
  sleep .05
done

# Function for clearing pins
clearPins() {
  echo "Clearing Pins"
  for pin in ${pins[@]}
  do
    gpio write ${pin} 1
  done
}

# function for writing letters
writeLetter() {
  
  case "$1" in
    h)
      declare -a letter=${arrayh[@]};;
    e)
      declare -a letter=${arraye[@]};;
    l)
      declare -a letter=${arrayl[@]};;
    o)
      declare -a letter=${arrayo[@]};;
  esac
  echo ${letter} 
  for pin in ${letter[@]}
  do 
    echo "Writing ${pin}" 
    gpio write ${pin} 0
  done
  sleep .75
}
#say hi 
for letter in ${hello[@]}
do
  echo ${letter}
  writeLetter ${letter}
  clearPins 
done

echo "cycle complete"
