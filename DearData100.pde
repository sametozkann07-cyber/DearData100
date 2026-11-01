class AppUsage {
  String name;
  int minutes;
  boolean enlarged = false;

  AppUsage(String appName, int appMinutes) {
    name = appName;
    minutes = appMinutes;
  }

  void display(int x, int r, int g, int b) {

    // Change colour when mouse hovers over circle
    if (dist(mouseX, mouseY, x, 200) < minutes / 2) {
      fill(255, 255, 0);
    } else {
      fill(r, g, b);
    }

    // Change size when clicked
    if (enlarged) {
      circle(x, 200, minutes * 1.5);
    } else {
      circle(x, 200, minutes);
    }

    fill(0);
    text(name, x, 310);
    text(minutes + " min", x, 340);
  }

  void checkClick(int x) {
    if (dist(mouseX, mouseY, x, 200) < minutes / 2) {
      enlarged = !enlarged;
    }
  }
}

AppUsage[] apps = {
  new AppUsage("Instagram", 69),
  new AppUsage("TikTok", 42),
  new AppUsage("Spotify", 37),
  new AppUsage("WhatsApp", 24),
  new AppUsage("Safari", 16),
  new AppUsage("YouTube", 7)
};

void setup() {
  size(1200, 500);
  textAlign(CENTER);
  textSize(16);
}

void draw() {
  background(240);

  for (int i = 0; i < apps.length; i++) {
    apps[i].display(150 + i * 180, 255, 80 + i * 25, 120);
  }
}

void mousePressed() {
  for (int i = 0; i < apps.length; i++) {
    apps[i].checkClick(150 + i * 180);
  }
}
