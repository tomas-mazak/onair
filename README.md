# (Somewhat) Intelligent do-not-disturb sign

![ON AIR sign illuminated](pictures/illuminated.jpg)

This repo contains 3D models and the code for a small tinker project: an
illuminated "ON AIR" sign that connects to WiFi and can be turned on/off over
the network.

The basic idea was to be able to let people around me know that I am on a video
call so they don't disturb me. I wanted something that is easily noticed, so
illuminated sign is great for that and I thought the famous radio "ON AIR"
message would be a good fun (ha ha). I also wanted to be able to control it
programatically, so I can automate it to illuminate when I have a zoom call
active on my laptop.

Hence I have created this 3D printed sign, with an ESP8266 controller, as that's
the cheapest chip I know that has WiFi. The controller runs a simple program
with mDNS responder, so I can access it using a hostname rather than IP that can
change, and a simple HTTP API, so I can send the ON and OFF commands to it over
the network.

For reference and for anyone who might want to build a similar sign, here's a
simple tutorial.

**DISCLAIMER:** I use Ubuntu Linux on my laptop, and Zoom desktop client pretty
much exclusively for video calls. This is a "works for me" project so you will
almost certainly need to adapt it to your needs.

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

The side consist of three 3D printed parts:

- [case front side](3d/stl/onair-front.stl)
- [case back side](3d/stl/onair-back.stl)
- [reflection screen](3d/stl/onair-reflection-screen.stl)

The back side has 2 standoffs for the MOSFET board and 4 standoffs for Raspberry
Pi (that I didn't use in the end). It has an attachment for a [wall mount like
this](https://www.obi.cz/nastenne-haky/lux-nastenny-hacek-plastovy-40-mm-bily-2-ks/p/4949582).

I recommend printing the case using black PETG filament and the screen using
white PETG filament. If you use Prusa i3MK3S(+) printer with PETG prusament,
you might use [my gcode](3d/gcode) directly.

If you need to like to modify the design, see the [OpenSCAD
source](3d/openscad/onair.scad). In such case, you will also need to install a
stencil font, I have used [Stencilia Regular](https://www.dafont.com/stencilia.font).

**Note:** I have used a spare NodeMCU (ESP8266) board with breadboard pins
already soldered, that I didn't feel like desoldering, and so I have affixed a
small breadboard to the back side of the sign case and plugged the board in. If
you have a controller board without breadboard pins, it would be better to add
standoffs for your board instead, attach the board with screw and and solder the
wires directly to the pins on the board. If you do so, don't forget to update
the position of USB access socket in the case front side model!

## Electronics

TODO

## Controller software

TODO

## Client script

TODO
