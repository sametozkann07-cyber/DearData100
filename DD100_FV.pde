// Dear Data 100 - Part 1 progress visualisation
// 32 observations from the first four days of the Observation Log.
// Each circle represents one app's screen-time observation.
// Circle size represents minutes; colour identifies the app.

String[] appNames = {
  "Instagram", "TikTok", "WhatsApp", "YouTube",
  "Phone", "Safari", "Spotify", "Google Maps"
};

color[] appColours = {
  #F26B8A, #A78BFA, #42BFA5, #F4B860,
  #7AA6D8, #E58C55, #5E9FE3, #8EAA72
};

String[] dates = {"14 OCT", "15 OCT", "16 OCT", "17 OCT"};
String[] days  = {"WED", "THU", "FRI", "SAT"};

// Rows are dates; columns are apps.
// The final date contains 7 observations in this 31-observation sample.
int[][] usage = {
  {41, 72, 32, 21, 13, 25, 16, 0},
  {83, 0, 20, 50, 30, 16, 9, 0},
  {76, 0, 74, 0, 41, 25, 23, 0},
  {84, 93, 75, 61, 17, 30, 0, 0}
};

int[] observationsPerDay = {8, 8, 8, 8};

String[] appShortNames = {
  "Instagram", "TikTok", "WhatsApp", "YouTube",
  "Phone", "Safari", "Spotify", "Google Maps"
};

float left = 205;
float top = 285;
float cellW = 135;
float cellH = 125;
float maxBubble = 66;

void setup() {
  size(1450, 900);
  smooth(8);
  textFont(createFont("Arial", 16));
}

void draw() {
  background(#101522);

  // Heading
  fill(#F4F1EA);
  textAlign(LEFT, TOP);
  textSize(15);
  fill(#9AA8BC);
  text("DEAR DATA 100  /  PART 1", 70, 48);

  fill(#F4F1EA);
  textSize(38);
  text("My screen time, day by day", 70, 82);

  fill(#AAB5C5);
  textSize(16);
  text("32 observations across 8 apps · 14–17 October 2026", 72, 137);

  // Main grid
  textSize(12);
  textAlign(CENTER, CENTER);
  for (int a = 0; a < appNames.length; a++) {
    fill(appColours[a]);
    text(appShortNames[a], left + a * cellW, 220);
  }

  for (int d = 0; d < dates.length; d++) {
    float y = top + d * cellH;

    textAlign(RIGHT, CENTER);
    fill(#F4F1EA);
    textSize(15);
    text(days[d], left - 72, y - 9);

    fill(#8996AA);
    textSize(12);
    text(dates[d], left - 72, y + 13);

    for (int a = 0; a < observationsPerDay[d]; a++) {
      float x = left + a * cellW;
      int minutes = usage[d][a];
      float diameter = minutes == 0 ? 9 : map(sqrt(minutes), 0, sqrt(100), 12, maxBubble);
      diameter = constrain(diameter, 9, maxBubble);

      // Subtle cell guide
      noFill();
      stroke(#273247);
      strokeWeight(1);
      ellipse(x, y, 86, 86);

      // Data mark
      if (minutes == 0) {
        noFill();
        stroke(appColours[a]);
        strokeWeight(2);
        ellipse(x, y, diameter, diameter);
      } else {
        noStroke();
        fill(appColours[a], 225);
        ellipse(x, y, diameter, diameter);
      }

      // Exact value
      fill(#F4F1EA);
      textAlign(CENTER, CENTER);
      textSize(12);
      text(minutes, x, y + 53);
    }
  }

  // Legend
  float legendY = 790;
  textAlign(LEFT, CENTER);
  fill(#AAB5C5);
  textSize(12);
  text("APP COLOURS", 72, legendY - 32);

  for (int a = 0; a < appNames.length; a++) {
    int col = a % 4;
    int row = a / 4;
    float x = 72 + col * 320;
    float y = legendY + row * 28;
    noStroke();
    fill(appColours[a]);
    ellipse(x + 7, y, 11, 11);
    fill(#DCE2EB);
    textSize(13);
    text(appNames[a], x + 22, y);
  }

  // Size key and footer
  fill(#8996AA);
  textAlign(RIGHT, CENTER);
  textSize(12);
  text("Circle size = minutes used   ·   Number = exact minutes   ·   Hollow circle = 0 minutes",
       1375, 850);

  // Hover details
  showHover();
}

void showHover() {
  for (int d = 0; d < dates.length; d++) {
    for (int a = 0; a < observationsPerDay[d]; a++) {
      float x = left + a * cellW;
      float y = top + d * cellH;
      int minutes = usage[d][a];
      float diameter = minutes == 0 ? 9 : map(sqrt(minutes), 0, sqrt(100), 12, maxBubble);
      diameter = constrain(diameter, 9, maxBubble);

      if (dist(mouseX, mouseY, x, y) < max(22, diameter / 2 + 5)) {
        String detail = appNames[a] + "  ·  " + dates[d] + "  ·  " + minutes + " minutes";
        textSize(13);
        float boxW = textWidth(detail) + 28;
        float boxX = constrain(mouseX + 16, 12, width - boxW - 12);
        float boxY = constrain(mouseY - 42, 12, height - 55);

        noStroke();
        fill(#273247);
        rect(boxX, boxY, boxW, 34, 8);
        fill(#FFFFFF);
        textAlign(LEFT, CENTER);
        textSize(13);
        text(detail, boxX + 14, boxY + 17);
        return;
      }
    }
  }
}
