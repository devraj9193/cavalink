class AlphaHelper {
  /// Convert opacity (0.0 to 1.0) → alpha (0 to 255)
  static int fromOpacity(double opacity) {
    return (opacity * 255).round().clamp(0, 255);
  }

  /// Convert alpha (0 to 255) → opacity (0.0 to 1.0)
  static double toOpacity(int alpha) {
    return (alpha / 255).clamp(0.0, 1.0);
  }

  /// Predefined mapping (double keys) - must be `final`, NOT `const`
  static final Map<double, int> opacityToAlphaMap = {
    0.0: 0,
    0.1: 25,
    0.2: 51,
    0.3: 76,
    0.4: 102,
    0.5: 128,
    0.6: 153,
    0.7: 179,
    0.8: 204,
    0.9: 230,
    1.0: 255,
  };

  /// Predefined mapping using int keys (0-100) for const usage
  static const Map<int, int> opacityToAlphaMapIntKeys = {
    0: 0,
    10: 25,
    20: 51,
    30: 76,
    40: 102,
    50: 128,
    60: 153,
    70: 179,
    80: 204,
    90: 230,
    100: 255,
  };

  /// Predefined reverse mapping (alpha → opacity)
  static const Map<int, double> alphaToOpacityMap = {
    0: 0.0,
    25: 0.1,
    51: 0.2,
    76: 0.3,
    102: 0.4,
    128: 0.5,
    153: 0.6,
    179: 0.7,
    204: 0.8,
    230: 0.9,
    255: 1.0,
  };

  /// Get alpha using int key map (0.0 to 1.0 -> 0 to 100)
  static int getAlphaFromOpacityLevel(double opacity) {
    final key = (opacity * 100).round();
    return opacityToAlphaMapIntKeys[key] ?? fromOpacity(opacity);
  }
}
