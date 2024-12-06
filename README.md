# AmbTemp
An ambient temperature sensing system written in Python.

## Repository Contents
```
ambtemp-bin - Actual program, uses I2C to communicate with temperature sensor and character LCD.
ambtemp.sh - SysVinit service script, allows ambtemp-bin to run on startup.
```

## Dependencies
The following dependencies (and their dependencies) are required for this program to run properly:
* adafruit-blinka
* adafruit-circuitpython-charlcd
* adafruit-circuitpython-bme280
* gpiod
* libgpiod
