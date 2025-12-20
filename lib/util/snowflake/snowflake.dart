class Snowflake {
  double x;
  double y;
  double radius;
  double speed;

  Snowflake({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
  });

  void fall(double height) {
    y += speed;

    if (y > height) {
      y = 0;
    }
  }
}
