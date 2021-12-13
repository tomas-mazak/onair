#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266mDNS.h>
#include <ESPAsyncTCP.h>
#include <ESPAsyncWebServer.h>
#include "main.h"
#include "config.h"

unsigned long sessions[sizeof(USERS)/sizeof(user_t)];
AsyncWebServer server(80);

void blink(int t) {
  digitalWrite(LED, HIGH);
  delay(t);
  digitalWrite(LED, LOW);
  delay(t);
}

void updateStatus() {
  unsigned long now = millis();
  bool on = false;
  for (unsigned int i=0; i<(sizeof(sessions)/sizeof(sessions[0])); i++) {
    if (sessions[i] > now)
      on = true;
  }
  if(on) {
    digitalWrite(LED, HIGH);
  } else {
    digitalWrite(LED, LOW);
  }
}

void session(AsyncWebServerRequest *request, bool on) {
  int user = -1;
  for(unsigned int i=0; i<(sizeof(USERS) / sizeof(USERS[0])); i++) {
    Serial.print("Trying to authenticate as ");
    Serial.print(USERS[i].user);
    Serial.print(" ");
    Serial.println(USERS[i].password);
    if(request->authenticate(USERS[i].user, USERS[i].password)) {
      user = i;
      break;
    }
  }
  if(user == -1) {
    request->requestAuthentication();
    return;
  }

  if(on) {
    sessions[user] = millis() + SESSION_TIMEOUT * 1000;
  } else {
    sessions[user] = 0;
  }
  updateStatus();
  request->send(200, "text/plain", "OK\n");
}

void accessLog(AsyncWebServerRequest *request) {
  Serial.print(request->client()->getRemoteAddress());
  Serial.println();
}

void setup() {
  // setup LED output
  pinMode(LED, OUTPUT);
  digitalWrite(LED, LOW);

  // setup serial port
  Serial.begin(115200);

  // setup WiFi
  WiFi.begin(WIFI_SSID, WIFI_PASS);
  while (WiFi.status() != WL_CONNECTED) {
    blink(250);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to WiFi network ");
  Serial.println(WIFI_SSID);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

  // setup MDNS
  if (MDNS.begin(MDNS_HOSTNAME)) {
    Serial.print("MDNS responder is ON for ");
    Serial.println(MDNS_HOSTNAME);
  }

  // setup HTTP
  server.on("/on", [](AsyncWebServerRequest *request) {
    accessLog(request);
    session(request, true);
  });
  server.on("/off", [](AsyncWebServerRequest *request) {
    accessLog(request);
    session(request, false);
  });
  server.begin();
  Serial.println("HTTP server is ON");
}

void loop() {
  // ensure the hostname is resolvable in local network
  MDNS.update();
  // remove expired sessions and update the light status
  updateStatus();
  delay(500);
}
