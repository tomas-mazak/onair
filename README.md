# (Somewhat) Intelligent do-not-disturb sign

This repo contains 3D models and code for a a small tinker project: an illuminated sign "ON AIR"
that connects to WiFi and can be turned on/off over the network.

The basic idea was to be able to signal to people around me that I am on a video call so they
don't disturb me. I wanted something that catches eye (so illuminated sign would do) and I thought
the famous radio "ON AIR" message would be a good fun (ha ha). I also wanted to be able to control
it programatically, so I can script it to illuminate when I have a zoom call active on my laptop.

So I have created this 3D printed sign, with an ESP8266 controller, as that's the cheapest chip
I know that has WiFi. The controller runs a simple program with MDNS responder (so I can access it
using a hostname rather than IP) and HTTP (so I can send the ON and OFF commands to it over
the network.

For reference and for anyone who might want to build a similar sign, here's a simple tutorial.

DISCLAIMER: I use Ubuntu Linux on my laptop, and Zoom desktop client pretty much exclusively for
video calls. This is a "works for me" project so you will almost certainly need to adapt it to your
needs somewhat.

## Parts list

  * [ESP8266 controller board (NodeMCU or similar)](https://www.gme.cz/esp12n-v1-0-nodemcu-lua267-esp8266-cp1202)
  * [MOSFET IRF520 module](https://www.gme.cz/modul-s-n-channel-mosfet-irf520)
  * [12V 1500mA power supply with 5.5x2.1mm jack](https://www.gme.cz/napajeci-adapter-sitovy-12v-1500ma-5-5-2-1mm-b-vigan)
  * [DC jack socket 5.5x2.1mm - panel mount](https://www.gme.cz/napajeci-souosy-konektor-ds-223b)
  * [DC-DC step-down converter 12V to 5V](https://www.gme.cz/step-down-napajeci-modul-1-17v-1a-miniaturni)
  * [Red LED strip 12V](https://www.gme.cz/led-pasek-120led-m-red-9-6w-m-ip65-3-m)
  * 2.2x6.5mm screws
  * Optional: [Small breadboard](https://www.gme.cz/nepajive-kontaktni-pole-zy-60)

## 3D print

**Note:** I have used a spare NodeMCU board with breadboard pins already soldered, that I didn't
feel like desoldering, and so I have stuck a small breadboard down and plugged the board in. If
you have a controller board without breadboard pins, it would be better to add standoffs for your
board to the back side of the case and solder only the four wires you need directly to the board.
Don't forget to update the position of socket for USB access in the case front side model!

## Electronics

## Controller software

## Client script
