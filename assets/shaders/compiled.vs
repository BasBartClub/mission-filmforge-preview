{@}aastep.glsl{@}float aastep(float threshold, float value) {
    float afwidth = length(vec2(dFdx(value), dFdy(value))) * 0.70710678118654757;
    return smoothstep(threshold-afwidth, threshold+afwidth, value);
}

float aastep(float threshold, float value, float padding) {
    return smoothstep(threshold - padding, threshold + padding, value);
}

vec2 aastep(vec2 threshold, vec2 value) {
    return vec2(
        aastep(threshold.x, value.x),
        aastep(threshold.y, value.y)
    );
}{@}blendmodes.glsl{@}float blendColorDodge(float base, float blend) {
    return (blend == 1.0)?blend:min(base/(1.0-blend), 1.0);
}
vec3 blendColorDodge(vec3 base, vec3 blend) {
    return vec3(blendColorDodge(base.r, blend.r), blendColorDodge(base.g, blend.g), blendColorDodge(base.b, blend.b));
}
vec3 blendColorDodge(vec3 base, vec3 blend, float opacity) {
    return (blendColorDodge(base, blend) * opacity + base * (1.0 - opacity));
}
float blendColorBurn(float base, float blend) {
    return (blend == 0.0)?blend:max((1.0-((1.0-base)/blend)), 0.0);
}
vec3 blendColorBurn(vec3 base, vec3 blend) {
    return vec3(blendColorBurn(base.r, blend.r), blendColorBurn(base.g, blend.g), blendColorBurn(base.b, blend.b));
}
vec3 blendColorBurn(vec3 base, vec3 blend, float opacity) {
    return (blendColorBurn(base, blend) * opacity + base * (1.0 - opacity));
}
float blendVividLight(float base, float blend) {
    return (blend<0.5)?blendColorBurn(base, (2.0*blend)):blendColorDodge(base, (2.0*(blend-0.5)));
}
vec3 blendVividLight(vec3 base, vec3 blend) {
    return vec3(blendVividLight(base.r, blend.r), blendVividLight(base.g, blend.g), blendVividLight(base.b, blend.b));
}
vec3 blendVividLight(vec3 base, vec3 blend, float opacity) {
    return (blendVividLight(base, blend) * opacity + base * (1.0 - opacity));
}
float blendHardMix(float base, float blend) {
    return (blendVividLight(base, blend)<0.5)?0.0:1.0;
}
vec3 blendHardMix(vec3 base, vec3 blend) {
    return vec3(blendHardMix(base.r, blend.r), blendHardMix(base.g, blend.g), blendHardMix(base.b, blend.b));
}
vec3 blendHardMix(vec3 base, vec3 blend, float opacity) {
    return (blendHardMix(base, blend) * opacity + base * (1.0 - opacity));
}
float blendLinearDodge(float base, float blend) {
    return min(base+blend, 1.0);
}
vec3 blendLinearDodge(vec3 base, vec3 blend) {
    return min(base+blend, vec3(1.0));
}
vec3 blendLinearDodge(vec3 base, vec3 blend, float opacity) {
    return (blendLinearDodge(base, blend) * opacity + base * (1.0 - opacity));
}
float blendLinearBurn(float base, float blend) {
    return max(base+blend-1.0, 0.0);
}
vec3 blendLinearBurn(vec3 base, vec3 blend) {
    return max(base+blend-vec3(1.0), vec3(0.0));
}
vec3 blendLinearBurn(vec3 base, vec3 blend, float opacity) {
    return (blendLinearBurn(base, blend) * opacity + base * (1.0 - opacity));
}
float blendLinearLight(float base, float blend) {
    return blend<0.5?blendLinearBurn(base, (2.0*blend)):blendLinearDodge(base, (2.0*(blend-0.5)));
}
vec3 blendLinearLight(vec3 base, vec3 blend) {
    return vec3(blendLinearLight(base.r, blend.r), blendLinearLight(base.g, blend.g), blendLinearLight(base.b, blend.b));
}
vec3 blendLinearLight(vec3 base, vec3 blend, float opacity) {
    return (blendLinearLight(base, blend) * opacity + base * (1.0 - opacity));
}
float blendLighten(float base, float blend) {
    return max(blend, base);
}
vec3 blendLighten(vec3 base, vec3 blend) {
    return vec3(blendLighten(base.r, blend.r), blendLighten(base.g, blend.g), blendLighten(base.b, blend.b));
}
vec3 blendLighten(vec3 base, vec3 blend, float opacity) {
    return (blendLighten(base, blend) * opacity + base * (1.0 - opacity));
}
float blendDarken(float base, float blend) {
    return min(blend, base);
}
vec3 blendDarken(vec3 base, vec3 blend) {
    return vec3(blendDarken(base.r, blend.r), blendDarken(base.g, blend.g), blendDarken(base.b, blend.b));
}
vec3 blendDarken(vec3 base, vec3 blend, float opacity) {
    return (blendDarken(base, blend) * opacity + base * (1.0 - opacity));
}
float blendPinLight(float base, float blend) {
    return (blend<0.5)?blendDarken(base, (2.0*blend)):blendLighten(base, (2.0*(blend-0.5)));
}
vec3 blendPinLight(vec3 base, vec3 blend) {
    return vec3(blendPinLight(base.r, blend.r), blendPinLight(base.g, blend.g), blendPinLight(base.b, blend.b));
}
vec3 blendPinLight(vec3 base, vec3 blend, float opacity) {
    return (blendPinLight(base, blend) * opacity + base * (1.0 - opacity));
}
float blendReflect(float base, float blend) {
    return (blend == 1.0)?blend:min(base*base/(1.0-blend), 1.0);
}
vec3 blendReflect(vec3 base, vec3 blend) {
    return vec3(blendReflect(base.r, blend.r), blendReflect(base.g, blend.g), blendReflect(base.b, blend.b));
}
vec3 blendReflect(vec3 base, vec3 blend, float opacity) {
    return (blendReflect(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendGlow(vec3 base, vec3 blend) {
    return blendReflect(blend, base);
}
vec3 blendGlow(vec3 base, vec3 blend, float opacity) {
    return (blendGlow(base, blend) * opacity + base * (1.0 - opacity));
}
float blendOverlay(float base, float blend) {
    return base<0.5?(2.0*base*blend):(1.0-2.0*(1.0-base)*(1.0-blend));
}
vec3 blendOverlay(vec3 base, vec3 blend) {
    return vec3(blendOverlay(base.r, blend.r), blendOverlay(base.g, blend.g), blendOverlay(base.b, blend.b));
}
vec3 blendOverlay(vec3 base, vec3 blend, float opacity) {
    return (blendOverlay(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendHardLight(vec3 base, vec3 blend) {
    return blendOverlay(blend, base);
}
vec3 blendHardLight(vec3 base, vec3 blend, float opacity) {
    return (blendHardLight(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendPhoenix(vec3 base, vec3 blend) {
    return min(base, blend)-max(base, blend)+vec3(1.0);
}
vec3 blendPhoenix(vec3 base, vec3 blend, float opacity) {
    return (blendPhoenix(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendNormal(vec3 base, vec3 blend) {
    return blend;
}
vec3 blendNormal(vec3 base, vec3 blend, float opacity) {
    return (blendNormal(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendNegation(vec3 base, vec3 blend) {
    return vec3(1.0)-abs(vec3(1.0)-base-blend);
}
vec3 blendNegation(vec3 base, vec3 blend, float opacity) {
    return (blendNegation(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendMultiply(vec3 base, vec3 blend) {
    return base*blend;
}
vec3 blendMultiply(vec3 base, vec3 blend, float opacity) {
    return (blendMultiply(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendAverage(vec3 base, vec3 blend) {
    return (base+blend)/2.0;
}
vec3 blendAverage(vec3 base, vec3 blend, float opacity) {
    return (blendAverage(base, blend) * opacity + base * (1.0 - opacity));
}
float blendScreen(float base, float blend) {
    return 1.0-((1.0-base)*(1.0-blend));
}
vec3 blendScreen(vec3 base, vec3 blend) {
    return vec3(blendScreen(base.r, blend.r), blendScreen(base.g, blend.g), blendScreen(base.b, blend.b));
}
vec3 blendScreen(vec3 base, vec3 blend, float opacity) {
    return (blendScreen(base, blend) * opacity + base * (1.0 - opacity));
}
float blendSoftLight(float base, float blend) {
    return (blend<0.5)?(2.0*base*blend+base*base*(1.0-2.0*blend)):(sqrt(base)*(2.0*blend-1.0)+2.0*base*(1.0-blend));
}
vec3 blendSoftLight(vec3 base, vec3 blend) {
    return vec3(blendSoftLight(base.r, blend.r), blendSoftLight(base.g, blend.g), blendSoftLight(base.b, blend.b));
}
vec3 blendSoftLight(vec3 base, vec3 blend, float opacity) {
    return (blendSoftLight(base, blend) * opacity + base * (1.0 - opacity));
}
float blendSubtract(float base, float blend) {
    return max(base+blend-1.0, 0.0);
}
vec3 blendSubtract(vec3 base, vec3 blend) {
    return max(base+blend-vec3(1.0), vec3(0.0));
}
vec3 blendSubtract(vec3 base, vec3 blend, float opacity) {
    return (blendSubtract(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendExclusion(vec3 base, vec3 blend) {
    return base+blend-2.0*base*blend;
}
vec3 blendExclusion(vec3 base, vec3 blend, float opacity) {
    return (blendExclusion(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendDifference(vec3 base, vec3 blend) {
    return abs(base-blend);
}
vec3 blendDifference(vec3 base, vec3 blend, float opacity) {
    return (blendDifference(base, blend) * opacity + base * (1.0 - opacity));
}
float blendAdd(float base, float blend) {
    return min(base+blend, 1.0);
}
vec3 blendAdd(vec3 base, vec3 blend) {
    return min(base+blend, vec3(1.0));
}
vec3 blendAdd(vec3 base, vec3 blend, float opacity) {
    return (blendAdd(base, blend) * opacity + base * (1.0 - opacity));
}{@}conditionals.glsl{@}vec4 when_eq(vec4 x, vec4 y) {
  return 1.0 - abs(sign(x - y));
}

vec4 when_neq(vec4 x, vec4 y) {
  return abs(sign(x - y));
}

vec4 when_gt(vec4 x, vec4 y) {
  return max(sign(x - y), 0.0);
}

vec4 when_lt(vec4 x, vec4 y) {
  return max(sign(y - x), 0.0);
}

vec4 when_ge(vec4 x, vec4 y) {
  return 1.0 - when_lt(x, y);
}

vec4 when_le(vec4 x, vec4 y) {
  return 1.0 - when_gt(x, y);
}

vec3 when_eq(vec3 x, vec3 y) {
  return 1.0 - abs(sign(x - y));
}

vec3 when_neq(vec3 x, vec3 y) {
  return abs(sign(x - y));
}

vec3 when_gt(vec3 x, vec3 y) {
  return max(sign(x - y), 0.0);
}

vec3 when_lt(vec3 x, vec3 y) {
  return max(sign(y - x), 0.0);
}

vec3 when_ge(vec3 x, vec3 y) {
  return 1.0 - when_lt(x, y);
}

vec3 when_le(vec3 x, vec3 y) {
  return 1.0 - when_gt(x, y);
}

vec2 when_eq(vec2 x, vec2 y) {
  return 1.0 - abs(sign(x - y));
}

vec2 when_neq(vec2 x, vec2 y) {
  return abs(sign(x - y));
}

vec2 when_gt(vec2 x, vec2 y) {
  return max(sign(x - y), 0.0);
}

vec2 when_lt(vec2 x, vec2 y) {
  return max(sign(y - x), 0.0);
}

vec2 when_ge(vec2 x, vec2 y) {
  return 1.0 - when_lt(x, y);
}

vec2 when_le(vec2 x, vec2 y) {
  return 1.0 - when_gt(x, y);
}

float when_eq(float x, float y) {
  return 1.0 - abs(sign(x - y));
}

float when_neq(float x, float y) {
  return abs(sign(x - y));
}

float when_gt(float x, float y) {
  return max(sign(x - y), 0.0);
}

float when_lt(float x, float y) {
  return max(sign(y - x), 0.0);
}

float when_ge(float x, float y) {
  return 1.0 - when_lt(x, y);
}

float when_le(float x, float y) {
  return 1.0 - when_gt(x, y);
}

vec4 and(vec4 a, vec4 b) {
  return a * b;
}

vec4 or(vec4 a, vec4 b) {
  return min(a + b, 1.0);
}

vec4 Not(vec4 a) {
  return 1.0 - a;
}

vec3 and(vec3 a, vec3 b) {
  return a * b;
}

vec3 or(vec3 a, vec3 b) {
  return min(a + b, 1.0);
}

vec3 Not(vec3 a) {
  return 1.0 - a;
}

vec2 and(vec2 a, vec2 b) {
  return a * b;
}

vec2 or(vec2 a, vec2 b) {
  return min(a + b, 1.0);
}


vec2 Not(vec2 a) {
  return 1.0 - a;
}

float and(float a, float b) {
  return a * b;
}

float or(float a, float b) {
  return min(a + b, 1.0);
}

float Not(float a) {
  return 1.0 - a;
}{@}eases.glsl{@}#ifndef PI
#define PI 3.141592653589793
#endif

#ifndef HALF_PI
#define HALF_PI 1.5707963267948966
#endif

float backInOut(float t) {
  float f = t < 0.5
    ? 2.0 * t
    : 1.0 - (2.0 * t - 1.0);

  float g = pow(f, 3.0) - f * sin(f * PI);

  return t < 0.5
    ? 0.5 * g
    : 0.5 * (1.0 - g) + 0.5;
}

float backIn(float t) {
  return pow(t, 3.0) - t * sin(t * PI);
}

float backOut(float t) {
  float f = 1.0 - t;
  return 1.0 - (pow(f, 3.0) - f * sin(f * PI));
}

float bounceOut(float t) {
  const float a = 4.0 / 11.0;
  const float b = 8.0 / 11.0;
  const float c = 9.0 / 10.0;

  const float ca = 4356.0 / 361.0;
  const float cb = 35442.0 / 1805.0;
  const float cc = 16061.0 / 1805.0;

  float t2 = t * t;

  return t < a
    ? 7.5625 * t2
    : t < b
      ? 9.075 * t2 - 9.9 * t + 3.4
      : t < c
        ? ca * t2 - cb * t + cc
        : 10.8 * t * t - 20.52 * t + 10.72;
}

float bounceIn(float t) {
  return 1.0 - bounceOut(1.0 - t);
}

float bounceInOut(float t) {
  return t < 0.5
    ? 0.5 * (1.0 - bounceOut(1.0 - t * 2.0))
    : 0.5 * bounceOut(t * 2.0 - 1.0) + 0.5;
}

float circularInOut(float t) {
  return t < 0.5
    ? 0.5 * (1.0 - sqrt(1.0 - 4.0 * t * t))
    : 0.5 * (sqrt((3.0 - 2.0 * t) * (2.0 * t - 1.0)) + 1.0);
}

float circularIn(float t) {
  return 1.0 - sqrt(1.0 - t * t);
}

float circularOut(float t) {
  return sqrt((2.0 - t) * t);
}

float cubicInOut(float t) {
  return t < 0.5
    ? 4.0 * t * t * t
    : 0.5 * -pow(2.0 - 2.0 * t, 3.0) + 1.0;
}

float cubicIn(float t) {
  return t * t * t;
}

float cubicOut(float t) {
  float f = t - 1.0;
  return f * f * f + 1.0;
}

float elasticInOut(float t) {
  return t < 0.5
    ? 0.5 * sin(+13.0 * HALF_PI * 2.0 * t) * pow(2.0, 10.0 * (2.0 * t - 1.0))
    : 0.5 * sin(-13.0 * HALF_PI * ((2.0 * t - 1.0) + 1.0)) * pow(2.0, -10.0 * (2.0 * t - 1.0)) + 1.0;
}

float elasticIn(float t) {
  return sin(13.0 * t * HALF_PI) * pow(2.0, 10.0 * (t - 1.0));
}

float elasticOut(float t) {
  return sin(-13.0 * (t + 1.0) * HALF_PI) * pow(2.0, -10.0 * t) + 1.0;
}

float expoInOut(float t) {
  return t == 0.0 || t == 1.0
    ? t
    : t < 0.5
      ? +0.5 * pow(2.0, (20.0 * t) - 10.0)
      : -0.5 * pow(2.0, 10.0 - (t * 20.0)) + 1.0;
}

float expoIn(float t) {
  return t == 0.0 ? t : pow(2.0, 10.0 * (t - 1.0));
}

float expoOut(float t) {
  return t == 1.0 ? t : 1.0 - pow(2.0, -10.0 * t);
}

float linear(float t) {
  return t;
}

float quadraticInOut(float t) {
  float p = 2.0 * t * t;
  return t < 0.5 ? p : -p + (4.0 * t) - 1.0;
}

float quadraticIn(float t) {
  return t * t;
}

float quadraticOut(float t) {
  return -t * (t - 2.0);
}

float quarticInOut(float t) {
  return t < 0.5
    ? +8.0 * pow(t, 4.0)
    : -8.0 * pow(1.0 - t, 4.0) + 1.0;
}

float quarticIn(float t) {
  return pow(t, 4.0);
}

float quarticOut(float t) {
  return pow(1.0 - t, 3.0) * (t - 1.0) + 1.0;
}

float qinticInOut(float t) {
  return t < 0.5
    ? +16.0 * pow(t, 5.0)
    : -0.5 * pow(2.0 * t - 2.0, 5.0) + 1.0;
}

float qinticIn(float t) {
  return pow(t, 5.0);
}

float qinticOut(float t) {
  return 1.0 - (pow(1.0 - t, 5.0));
}

float sineInOut(float t) {
  return -0.5 * (cos(PI * t) - 1.0);
}

float sineIn(float t) {
  return sin((t - 1.0) * HALF_PI) + 1.0;
}

float sineOut(float t) {
  return sin(t * HALF_PI);
}
{@}ColorMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 color;
uniform float alpha;

#!VARYINGS

#!SHADER: ColorMaterial.vs
void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: ColorMaterial.fs
void main() {
    gl_FragColor = vec4(color, alpha);
}{@}DebugCamera.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;

#!VARYINGS
varying vec3 vColor;

#!SHADER: DebugCamera.vs
void main() {
    vColor = mix(uColor, vec3(1.0, 0.0, 0.0), step(position.z, -0.1));
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: DebugCamera.fs
void main() {
    gl_FragColor = vec4(vColor, 1.0);
}{@}OcclusionMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 bbMin;
uniform vec3 bbMax;

#!VARYINGS

#!SHADER: Vertex.vs
void main() {
    vec3 pos = position;
    pos *= bbMax - bbMin;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment.fs
void main() {
    gl_FragColor = vec4(1.0);
}{@}ScreenQuad.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;

#!VARYINGS

#!SHADER: ScreenQuad.vs
void main() {
    gl_Position = vec4(position, 1.0);
}

#!SHADER: ScreenQuad.fs
void main() {
    gl_FragColor = texture2D(tMap, gl_FragCoord.xy / resolution);
    gl_FragColor.a = 1.0;
}{@}ScreenQuadVR.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uEye;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

vec2 scaleUV(vec2 uv, vec2 scale, vec2 origin) {
    vec2 st = uv - origin;
    st /= scale;
    return st + origin;
}

void main() {
    vUv = scaleUV(uv, vec2(2.0, 1.0), vec2(0.0)) - vec2(uEye, 0.0);
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = texture2D(tMap, vUv);
}{@}TestMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform float alpha;

#!VARYINGS
varying vec3 vNormal;

#!SHADER: TestMaterial.vs
void main() {
    vec3 pos = position;
    vNormal = normalMatrix * normal;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: TestMaterial.fs
void main() {
    gl_FragColor = vec4(vNormal, 1.0);
}{@}TextureMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;

#!VARYINGS
varying vec2 vUv;

#!SHADER: TextureMaterial.vs
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: TextureMaterial.fs
void main() {
    gl_FragColor = texture2D(tMap, vUv);
    gl_FragColor.rgb /= gl_FragColor.a;
}{@}BlitPass.fs{@}void main() {
    gl_FragColor = texture2D(tDiffuse, vUv);
}
{@}NukePass.vs{@}varying vec2 vUv;

void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}{@}ShadowDepth.glsl{@}#!ATTRIBUTES

#!UNIFORMS

#!VARYINGS

#!SHADER: ShadowDepth.vs
void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: ShadowDepth.fs
void main() {
    gl_FragColor = vec4(vec3(gl_FragCoord.x), 1.0);
}{@}instance.vs{@}vec3 transformNormal(vec3 n, vec4 orientation) {
    vec3 nn = n + 2.0 * cross(orientation.xyz, cross(orientation.xyz, n) + orientation.w * n);
    return nn;
}

vec3 transformPosition(vec3 position, vec3 offset, vec3 scale, vec4 orientation) {
    vec3 _pos = position;
    _pos *= scale;

    _pos = _pos + 2.0 * cross(orientation.xyz, cross(orientation.xyz, _pos) + orientation.w * _pos);
    _pos += offset;
    return _pos;
}

vec3 transformPosition(vec3 position, vec3 offset, vec4 orientation) {
    vec3 _pos = position;

    _pos = _pos + 2.0 * cross(orientation.xyz, cross(orientation.xyz, _pos) + orientation.w * _pos);
    _pos += offset;
    return _pos;
}

vec3 transformPosition(vec3 position, vec3 offset, float scale, vec4 orientation) {
    return transformPosition(position, offset, vec3(scale), orientation);
}

vec3 transformPosition(vec3 position, vec3 offset) {
    return position + offset;
}

vec3 transformPosition(vec3 position, vec3 offset, float scale) {
    vec3 pos = position * scale;
    return pos + offset;
}

vec3 transformPosition(vec3 position, vec3 offset, vec3 scale) {
    vec3 pos = position * scale;
    return pos + offset;
}{@}lights.fs{@}vec3 worldLight(vec3 pos, vec3 vpos) {
    vec4 mvPos = modelViewMatrix * vec4(vpos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(pos, 1.0);
    return worldPosition.xyz - mvPos.xyz;
}{@}lights.vs{@}vec3 worldLight(vec3 pos) {
    vec4 mvPos = modelViewMatrix * vec4(position, 1.0);
    vec4 worldPosition = viewMatrix * vec4(pos, 1.0);
    return worldPosition.xyz - mvPos.xyz;
}

vec3 worldLight(vec3 lightPos, vec3 localPos) {
    vec4 mvPos = modelViewMatrix * vec4(localPos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(lightPos, 1.0);
    return worldPosition.xyz - mvPos.xyz;
}{@}shadows.fs{@}#define PI2 6.2831853072
#define PI 3.141592653589793

#define MAX_PCSS_SAMPLES 17
vec2 poissonDisk[MAX_PCSS_SAMPLES];

struct PCSShadowConfig {
    int sampleCount;
    int ringCount;
    float lightWorldSize;
    float lightFrustumWidth;
    float nearPlane;
};

PCSShadowConfig defaultPCSSShadowConfig() {
    PCSShadowConfig config;
    config.sampleCount = 10;
    config.ringCount = 11;
    config.lightWorldSize = 0.3;
    config.lightFrustumWidth = 6.75;
    config.nearPlane = 6.5;
    return config;
}

bool frustumTest(vec3 coords) {
    return coords.x >= 0.0 && coords.x <= 1.0 && coords.y >= 0.0 && coords.y <= 1.0 && coords.z <= 1.0;
}

float rand(float n){return fract(sin(n) * 43758.5453123);}
highp float rand( const in vec2 uv ) {
    const highp float a = 12.9898, b = 78.233, c = 43758.5453;
    highp float dt = dot( uv.xy, vec2( a, b ) ), sn = mod( dt, PI );
    return fract( sin( sn ) * c );
}

void initPoissonSamples(const in vec2 randomSeed, PCSShadowConfig config) {
    float angleStep = PI2 * float(config.ringCount) / float(config.sampleCount);
    float invSampleCount = 1.0 / float(config.sampleCount);
    float angle = rand(randomSeed) * PI2;
    float radius = invSampleCount;
    float radiusStep = radius;
    
    for(int i = 0; i < MAX_PCSS_SAMPLES; i ++ ) {
        if( i > config.sampleCount ) {
            break;
        }
        poissonDisk[i] = vec2(cos(angle), sin(angle)) * pow(radius, 0.75);
        radius += radiusStep;
        angle += angleStep;
    }
}

float penumbraSize(const in float zReceiver, const in float zBlocker) {
    return (zReceiver - zBlocker) / zBlocker;
}

float findBlocker(sampler2D shadowMap, const in vec2 uv, const in float zReceiver, PCSShadowConfig config) {
    // This uses similar triangles to compute what
    // area of the shadow map we should search
    float lightSizeUV = config.lightWorldSize / config.lightFrustumWidth;
    float searchRadius = lightSizeUV * (zReceiver - config.nearPlane) / zReceiver;
    float blockerDepthSum = 0.0;
    int numBlockers = 0;
    
    for(int i = 0; i < MAX_PCSS_SAMPLES; i ++ ) {
        if( i > config.sampleCount ) {
            break;
        }
        float shadowMapDepth = texture2D(shadowMap, uv + poissonDisk[i] * searchRadius).r;
        if (shadowMapDepth < zReceiver) {
            blockerDepthSum += shadowMapDepth;
            numBlockers ++ ;
        }
    }
    
    if (numBlockers == 0)return -1.0;
    
    return blockerDepthSum / float(numBlockers);
}

float pcfFilter(sampler2D shadowMap, vec2 uv, float zReceiver, float filterRadius, PCSShadowConfig config) {
    float sum = 0.0;
    float depth;
    int numSamples = config.sampleCount;
    for(int i = 0; i < MAX_PCSS_SAMPLES; i ++ ) {
        if( i > numSamples ) {
            break;
        }
        depth = texture2D(shadowMap, uv + poissonDisk[i] * filterRadius).r;
        if (zReceiver <= depth) sum += 1.0;
    }
    for(int i = 0; i < MAX_PCSS_SAMPLES; i ++ ) {
        if( i > numSamples ) {
            break;
        }
        depth = texture2D(shadowMap, uv + -poissonDisk[i].yx * filterRadius).r;
        if (zReceiver <= depth) sum += 1.0;
    }
    return sum / (2.0 * float(numSamples));
}

float PCSS(sampler2D shadowMap, vec3 coords, PCSShadowConfig config) {
    vec2 uv = coords.xy;
    float zReceiver = coords.z; // Assumed to be eye-space z in this code
    
    initPoissonSamples(uv, config);
    
    float avgBlockerDepth = findBlocker(shadowMap, uv, zReceiver, config);
    if (avgBlockerDepth == -1.0)return 1.0; 

    float penumbraRatio = penumbraSize(zReceiver, avgBlockerDepth);
    float lightSizeUV = config.lightWorldSize / config.lightFrustumWidth;
    float filterRadius = penumbraRatio * lightSizeUV * config.nearPlane / zReceiver;    

    return pcfFilter(shadowMap, uv, zReceiver, filterRadius, config);
}

float shadowLookupPCSS(sampler2D map, vec3 coords, float size, float compare, vec3 wpos, PCSShadowConfig config) {
    float shadow = 1.0;
    bool frustumTest = frustumTest(coords);
    if (frustumTest) {
        shadow = PCSS(map, coords, config);
    }
    return clamp(shadow, 0.0, 1.0);
}

float shadowCompare(sampler2D map, vec2 coords, float compare) {
    return step(compare, texture2D(map, coords).r);
}

float shadowLerp(sampler2D map, vec2 coords, float compare, float size) {
    const vec2 offset = vec2(0.0, 1.0);

    vec2 texelSize = vec2(1.0) / size;
    vec2 centroidUV = floor(coords * size + 0.5) / size;

    float lb = shadowCompare(map, centroidUV + texelSize * offset.xx, compare);
    float lt = shadowCompare(map, centroidUV + texelSize * offset.xy, compare);
    float rb = shadowCompare(map, centroidUV + texelSize * offset.yx, compare);
    float rt = shadowCompare(map, centroidUV + texelSize * offset.yy, compare);

    vec2 f = fract( coords * size + 0.5 );

    float a = mix( lb, lt, f.y );
    float b = mix( rb, rt, f.y );
    float c = mix( a, b, f.x );

    return c;
}

float srange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    float oldRange = oldMax - oldMin;
    float newRange = newMax - newMin;
    return (((oldValue - oldMin) * newRange) / oldRange) + newMin;
}

float shadowrandom(vec3 vin) {
    vec3 v = vin * 0.1;
    float t = v.z * 0.3;
    v.y *= 0.8;
    float noise = 0.0;
    float s = 0.5;
    noise += srange(sin(v.x * 0.9 / s + t * 10.0) + sin(v.x * 2.4 / s + t * 15.0) + sin(v.x * -3.5 / s + t * 4.0) + sin(v.x * -2.5 / s + t * 7.1), -1.0, 1.0, -0.3, 0.3);
    noise += srange(sin(v.y * -0.3 / s + t * 18.0) + sin(v.y * 1.6 / s + t * 18.0) + sin(v.y * 2.6 / s + t * 8.0) + sin(v.y * -2.6 / s + t * 4.5), -1.0, 1.0, -0.3, 0.3);
    return noise;
}

float shadowLookup(sampler2D map, vec3 coords, float size, float compare, vec3 wpos) {
    float shadow = 1.0;

    #if defined(SHADOW_MAPS)
    bool frustumTest = coords.x >= 0.0 && coords.x <= 1.0 && coords.y >= 0.0 && coords.y <= 1.0 && coords.z <= 1.0;
    if (frustumTest) {
        
        vec2 texelSize = vec2(1.0) / size;

        float dx0 = -texelSize.x;
        float dy0 = -texelSize.y;
        float dx1 = +texelSize.x;
        float dy1 = +texelSize.y;

        float rnoise = shadowrandom(wpos) * 0.00015;
        dx0 += rnoise;
        dy0 -= rnoise;
        dx1 += rnoise;
        dy1 -= rnoise;

        #if defined(SHADOWS_MED)
        shadow += shadowCompare(map, coords.xy + vec2(0.0, dy0), compare);
        //        shadow += shadowCompare(map, coords.xy + vec2(dx1, dy0), compare);
        shadow += shadowCompare(map, coords.xy + vec2(dx0, 0.0), compare);
        shadow += shadowCompare(map, coords.xy, compare);
        shadow += shadowCompare(map, coords.xy + vec2(dx1, 0.0), compare);
        //        shadow += shadowCompare(map, coords.xy + vec2(dx0, dy1), compare);
        shadow += shadowCompare(map, coords.xy + vec2(0.0, dy1), compare);
        shadow /= 5.0;

        #elif defined(SHADOWS_HIGH)
        shadow = shadowLerp(map, coords.xy + vec2(dx0, dy0), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(0.0, dy0), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx1, dy0), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx0, 0.0), compare, size);
        shadow += shadowLerp(map, coords.xy, compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx1, 0.0), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx0, dy1), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(0.0, dy1), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx1, dy1), compare, size);
        shadow /= 9.0;

        #else
        shadow = shadowCompare(map, coords.xy, compare);
        #endif
    }

        #endif

    return clamp(shadow, 0.0, 1.0);
}

#test !!window.Metal
vec3 transformShadowLight(vec3 pos, vec3 vpos, mat4 mvMatrix, mat4 viewMatrix) {
    vec4 mvPos = mvMatrix * vec4(vpos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(pos, 1.0);
    return normalize(worldPosition.xyz - mvPos.xyz);
}

float getShadow(vec3 pos, vec3 normal, float bias, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    float shadow = 1.0;
    #if defined(SHADOW_MAPS)

    vec4 shadowMapCoords;
    vec3 coords;
    float lookup;

    for (int i = 0; i < SHADOW_COUNT; i++) {
        shadowMapCoords = uniforms.shadowMatrix[i] * vec4(pos, 1.0);
        coords = (shadowMapCoords.xyz / shadowMapCoords.w) * vec3(0.5) + vec3(0.5);
        lookup = shadowLookup(shadowMap, coords, uniforms.shadowSize[i], coords.z - bias, pos);
        lookup += mix(1.0 - step(0.002, dot(transformShadowLight(uniforms.shadowLightPos[i], pos, uniforms.modelViewMatrix, globalUniforms.viewMatrix), normal)), 0.0, step(999.0, normal.x));
        shadow *= clamp(lookup, 0.0, 1.0);
    }

    #endif
    return shadow;
}

float getShadow(vec3 pos, vec3 normal, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    return getShadow(pos, normal, 0.0, uniforms, globalUniforms, shadowMap);
}

float getShadow(vec3 pos, float bias, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    return getShadow(pos, vec3(99999.0), bias, uniforms, globalUniforms, shadowMap);
}

float getShadow(vec3 pos, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    return getShadow(pos, vec3(99999.0), 0.0, uniforms, globalUniforms, shadowMap);
}

float getShadow(vec3 pos, vec3 normal) {
    return 1.0;
}

float getShadow(vec3 pos, float bias) {
    return 1.0;
}

float getShadow(vec3 pos) {
    return 1.0;
}

float getShadowPCSS(vec3 pos, vec3 normal, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap, PCSShadowConfig config) {
    float shadow = 1.0;
    #if defined(SHADOW_MAPS)

    vec4 shadowMapCoords;
    vec3 coords;
    float lookup;

    for (int i = 0; i < SHADOW_COUNT; i++) {
        shadowMapCoords = uniforms.shadowMatrix[i] * vec4(pos, 1.0);
        coords = (shadowMapCoords.xyz / shadowMapCoords.w) * vec3(0.5) + vec3(0.5);
        lookup = shadowLookupPCSS(shadowMap, coords, uniforms.shadowSize[i], coords.z - bias, pos);
        lookup += mix(1.0 - step(0.002, dot(transformShadowLight(uniforms.shadowLightPos[i], pos, uniforms.modelViewMatrix, globalUniforms.viewMatrix), normal)), 0.0, step(999.0, normal.x));
        shadow *= clamp(lookup, 0.0, 1.0);
    }

    #endif
    return shadow;
}

float getShadowPCSS(vec3 pos, vec3 normal, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    PCSShadowConfig config = defaultPCSSShadowConfig();
    return getShadowPCSS(pos, normal, bias, config);
}

#endtest

#test !window.Metal
vec3 transformShadowLight(vec3 pos, vec3 vpos) {
    vec4 mvPos = modelViewMatrix * vec4(vpos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(pos, 1.0);
    return normalize(worldPosition.xyz - mvPos.xyz);
}

float getShadow(vec3 pos, vec3 normal, float bias) {

    float shadow = 1.0;
    #if defined(SHADOW_MAPS)

    vec4 shadowMapCoords;
    vec3 coords;
    float lookup;

    #pragma unroll_loop
    for (int i = 0; i < SHADOW_COUNT; i++) {
        shadowMapCoords = shadowMatrix[i] * vec4(pos, 1.0);
        coords = (shadowMapCoords.xyz / shadowMapCoords.w) * vec3(0.5) + vec3(0.5);
        lookup = shadowLookup(shadowMap[i], coords, shadowSize[i], coords.z - bias, pos);        
        lookup += mix(1.0 - step(0.002, dot(transformShadowLight(shadowLightPos[i], pos), normal)), 0.0, step(999.0, normal.x));
        shadow *= clamp(lookup, 0.0, 1.0);
    }
    #endif
    return shadow;
}

float getShadow(vec3 pos, vec3 normal) {
    return getShadow(pos, normal, 0.0);
}

float getShadow(vec3 pos, float bias) {
    return getShadow(pos, vec3(99999.0), bias);
}

float getShadow(vec3 pos) {
    return getShadow(pos, vec3(99999.0), 0.0);
}

float getShadowPCSS(vec3 pos, vec3 normal, float bias, PCSShadowConfig config) {    
    float shadow = 1.0;
    #if defined(SHADOW_MAPS)

    vec4 shadowMapCoords;
    vec3 coords;
    float lookup;

    #pragma unroll_loop
    for (int i = 0; i < SHADOW_COUNT; i++) {
        shadowMapCoords = shadowMatrix[i] * vec4(pos, 1.0);
        coords = (shadowMapCoords.xyz / shadowMapCoords.w) * vec3(0.5) + vec3(0.5);
        lookup = shadowLookupPCSS(shadowMap[i], coords, shadowSize[i], coords.z - bias, pos, config);
        lookup += mix(1.0 - step(0.002, dot(transformShadowLight(shadowLightPos[i], pos), normal)), 0.0, step(999.0, normal.x));
        shadow *= clamp(lookup, 0.0, 1.0);
    }
    #endif
    
    return shadow;
}

float getShadowPCSS(vec3 pos, vec3 normal, float bias) {
    PCSShadowConfig config = defaultPCSSShadowConfig();
    return getShadowPCSS(pos, normal, bias, config);
}
#endtest{@}FXAA.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMask;

#!VARYINGS
varying vec2 v_rgbNW;
varying vec2 v_rgbNE;
varying vec2 v_rgbSW;
varying vec2 v_rgbSE;
varying vec2 v_rgbM;

#!SHADER: FXAA.vs

varying vec2 vUv;

void main() {
    vUv = uv;

    vec2 fragCoord = uv * resolution;
    vec2 inverseVP = 1.0 / resolution.xy;
    v_rgbNW = (fragCoord + vec2(-1.0, -1.0)) * inverseVP;
    v_rgbNE = (fragCoord + vec2(1.0, -1.0)) * inverseVP;
    v_rgbSW = (fragCoord + vec2(-1.0, 1.0)) * inverseVP;
    v_rgbSE = (fragCoord + vec2(1.0, 1.0)) * inverseVP;
    v_rgbM = vec2(fragCoord * inverseVP);

    gl_Position = vec4(position, 1.0);
}

#!SHADER: FXAA.fs

#require(conditionals.glsl)

#ifndef FXAA_REDUCE_MIN
    #define FXAA_REDUCE_MIN   (1.0/ 128.0)
#endif
#ifndef FXAA_REDUCE_MUL
    #define FXAA_REDUCE_MUL   (1.0 / 8.0)
#endif
#ifndef FXAA_SPAN_MAX
    #define FXAA_SPAN_MAX     8.0
#endif

vec4 fxaa(sampler2D tex, vec2 fragCoord, vec2 resolution,
            vec2 v_rgbNW, vec2 v_rgbNE,
            vec2 v_rgbSW, vec2 v_rgbSE,
            vec2 v_rgbM) {
    vec4 color;
    mediump vec2 inverseVP = vec2(1.0 / resolution.x, 1.0 / resolution.y);
    vec3 rgbNW = texture2D(tex, v_rgbNW).xyz;
    vec3 rgbNE = texture2D(tex, v_rgbNE).xyz;
    vec3 rgbSW = texture2D(tex, v_rgbSW).xyz;
    vec3 rgbSE = texture2D(tex, v_rgbSE).xyz;
    vec4 texColor = texture2D(tex, v_rgbM);
    vec3 rgbM  = texColor.xyz;
    vec3 luma = vec3(0.299, 0.587, 0.114);
    float lumaNW = dot(rgbNW, luma);
    float lumaNE = dot(rgbNE, luma);
    float lumaSW = dot(rgbSW, luma);
    float lumaSE = dot(rgbSE, luma);
    float lumaM  = dot(rgbM,  luma);
    float lumaMin = min(lumaM, min(min(lumaNW, lumaNE), min(lumaSW, lumaSE)));
    float lumaMax = max(lumaM, max(max(lumaNW, lumaNE), max(lumaSW, lumaSE)));

    mediump vec2 dir;
    dir.x = -((lumaNW + lumaNE) - (lumaSW + lumaSE));
    dir.y =  ((lumaNW + lumaSW) - (lumaNE + lumaSE));

    float dirReduce = max((lumaNW + lumaNE + lumaSW + lumaSE) *
                          (0.25 * FXAA_REDUCE_MUL), FXAA_REDUCE_MIN);

    float rcpDirMin = 1.0 / (min(abs(dir.x), abs(dir.y)) + dirReduce);
    dir = min(vec2(FXAA_SPAN_MAX, FXAA_SPAN_MAX),
              max(vec2(-FXAA_SPAN_MAX, -FXAA_SPAN_MAX),
              dir * rcpDirMin)) * inverseVP;

    vec3 rgbA = 0.5 * (
        texture2D(tex, fragCoord * inverseVP + dir * (1.0 / 3.0 - 0.5)).xyz +
        texture2D(tex, fragCoord * inverseVP + dir * (2.0 / 3.0 - 0.5)).xyz);
    vec3 rgbB = rgbA * 0.5 + 0.25 * (
        texture2D(tex, fragCoord * inverseVP + dir * -0.5).xyz +
        texture2D(tex, fragCoord * inverseVP + dir * 0.5).xyz);

    float lumaB = dot(rgbB, luma);

    color = vec4(rgbB, texColor.a);
    color = mix(color, vec4(rgbA, texColor.a), when_lt(lumaB, lumaMin));
    color = mix(color, vec4(rgbA, texColor.a), when_gt(lumaB, lumaMax));

    return color;
}

void main() {
    vec2 fragCoord = vUv * resolution;
    float mask = texture2D(tMask, vUv).r;
    if (mask < 0.5) {
        gl_FragColor = fxaa(tDiffuse, fragCoord, resolution, v_rgbNW, v_rgbNE, v_rgbSW, v_rgbSE, v_rgbM);
    } else {
        gl_FragColor = texture2D(tDiffuse, vUv);
    }
    gl_FragColor.a = 1.0;
}
{@}DefaultText.glsl{@}#!ATTRIBUTES

#!UNIFORMS

uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS

varying vec2 vUv;

#!SHADER: DefaultText.vs

void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: DefaultText.fs

#require(msdf.glsl)

void main() {
    float alpha = msdf(tMap, vUv);

    gl_FragColor.rgb = uColor;
    gl_FragColor.a = alpha * uAlpha;
}
{@}msdf.glsl{@}float msdf(vec3 tex, vec2 uv, bool discards) {
    // TODO: fallback for fwidth for webgl1 (need to enable ext)
    float signedDist = max(min(tex.r, tex.g), min(max(tex.r, tex.g), tex.b)) - 0.5;
    float d = fwidth(signedDist);
    float alpha = smoothstep(-d, d, signedDist);
    if (alpha < 0.01 && discards) discard;
    return alpha;
}

float msdf(sampler2D tMap, vec2 uv, bool discards) {
    vec3 tex = texture2D(tMap, uv).rgb;
    return msdf( tex, uv, discards );
}

float msdf(vec3 tex, vec2 uv) {
    return msdf( tex, uv, true );
}

float msdf(sampler2D tMap, vec2 uv) {
    vec3 tex = texture2D(tMap, uv).rgb;
    return msdf( tex, uv );
}

float strokemsdf(sampler2D tMap, vec2 uv, float stroke, float padding) {
    vec3 tex = texture2D(tMap, uv).rgb;
    float signedDist = max(min(tex.r, tex.g), min(max(tex.r, tex.g), tex.b)) - 0.5;
    float t = stroke;
    float alpha = smoothstep(-t, -t + padding, signedDist) * smoothstep(t, t - padding, signedDist);
    return alpha;
}
{@}GLUIBatch.glsl{@}#!ATTRIBUTES
attribute vec3 offset;
attribute vec2 scale;
attribute float rotation;
//attributes

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;
//varyings

#!SHADER: Vertex

mat4 rotationMatrix(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;

    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
    oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
    oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
    0.0,                                0.0,                                0.0,                                1.0);
}

void main() {
    vUv = uv;
    //vdefines

    vec3 pos = vec3(rotationMatrix(vec3(0.0, 0.0, 1.0), rotation) * vec4(position, 1.0));
    pos.xy *= scale;
    pos.xyz += offset;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = vec4(1.0);
}{@}GLUIBatchText.glsl{@}#!ATTRIBUTES
attribute vec3 offset;
attribute vec2 scale;
attribute float rotation;
//attributes

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;
//varyings

#!SHADER: Vertex

mat4 lrotationMatrix(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;

    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
    oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
    oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
    0.0,                                0.0,                                0.0,                                1.0);
}

void main() {
    vUv = uv;
    //vdefines

    vec3 pos = vec3(lrotationMatrix(vec3(0.0, 0.0, 1.0), rotation) * vec4(position, 1.0));

    //custommain

    pos.xy *= scale;
    pos += offset;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(msdf.glsl)

void main() {
    float alpha = msdf(tMap, vUv);

    gl_FragColor.rgb = v_uColor;
    gl_FragColor.a = alpha * v_uAlpha;
}
{@}GLUIColor.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: GLUIColor.vs
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: GLUIColor.fs
void main() {
    vec2 uv = vUv;
    vec3 uvColor = vec3(uv, 1.0);
    gl_FragColor = vec4(mix(uColor, uvColor, 0.0), uAlpha);
}{@}GLUIObject.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: GLUIObject.vs
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: GLUIObject.fs
void main() {
    gl_FragColor = texture2D(tMap, vUv);
    gl_FragColor.a *= uAlpha;
}{@}gluimask.fs{@}uniform vec4 uMaskValues;

#require(range.glsl)

vec2 getMaskUV() {
    vec2 ores = gl_FragCoord.xy / resolution;
    vec2 uv;
    uv.x = range(ores.x, uMaskValues.x, uMaskValues.z, 0.0, 1.0);
    uv.y = 1.0 - range(1.0 - ores.y, uMaskValues.y, uMaskValues.w, 0.0, 1.0);
    return uv;
}{@}range.glsl{@}

float range(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    vec3 sub = vec3(oldValue, newMax, oldMax) - vec3(oldMin, newMin, oldMin);
    return sub.x * sub.y / sub.z + newMin;
}

vec2 range(vec2 oldValue, vec2 oldMin, vec2 oldMax, vec2 newMin, vec2 newMax) {
    vec2 oldRange = oldMax - oldMin;
    vec2 newRange = newMax - newMin;
    vec2 val = oldValue - oldMin;
    return val * newRange / oldRange + newMin;
}

vec3 range(vec3 oldValue, vec3 oldMin, vec3 oldMax, vec3 newMin, vec3 newMax) {
    vec3 oldRange = oldMax - oldMin;
    vec3 newRange = newMax - newMin;
    vec3 val = oldValue - oldMin;
    return val * newRange / oldRange + newMin;
}

float crange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    return clamp(range(oldValue, oldMin, oldMax, newMin, newMax), min(newMin, newMax), max(newMin, newMax));
}

vec2 crange(vec2 oldValue, vec2 oldMin, vec2 oldMax, vec2 newMin, vec2 newMax) {
    return clamp(range(oldValue, oldMin, oldMax, newMin, newMax), min(newMin, newMax), max(newMin, newMax));
}

vec3 crange(vec3 oldValue, vec3 oldMin, vec3 oldMax, vec3 newMin, vec3 newMax) {
    return clamp(range(oldValue, oldMin, oldMax, newMin, newMax), min(newMin, newMax), max(newMin, newMax));
}

float rangeTransition(float t, float x, float padding) {
    float transition = crange(t, 0.0, 1.0, -padding, 1.0 + padding);
    return crange(x, transition - padding, transition + padding, 1.0, 0.0);
}
{@}rotation.glsl{@}mat4 rotationMatrix(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;

    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
                oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
                oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
                0.0,                                0.0,                                0.0,                                1.0);
}


mat2 rotationMatrix(float angle) {
  float s = sin(angle);
  float c = cos(angle);
  return mat2(c, -s, s, c);
}{@}simplenoise.glsl{@}float getNoise(vec2 uv, float time) {
    float x = uv.x * uv.y * time * 1000.0;
    x = mod(x, 13.0) * mod(x, 123.0);
    float dx = mod(x, 0.01);
    float amount = clamp(0.1 + dx * 100.0, 0.0, 1.0);
    return amount;
}

#test Device.mobile
float sinf(float x) {
    x*=0.159155;
    x-=floor(x);
    float xx=x*x;
    float y=-6.87897;
    y=y*xx+33.7755;
    y=y*xx-72.5257;
    y=y*xx+80.5874;
    y=y*xx-41.2408;
    y=y*xx+6.28077;
    return x*y;
}
#endtest

#test !Device.mobile
    #define sinf sin
#endtest

highp float getRandom(vec2 co) {
    highp float a = 12.9898;
    highp float b = 78.233;
    highp float c = 43758.5453;
    highp float dt = dot(co.xy, vec2(a, b));
    highp float sn = mod(dt, 3.14);
    return fract(sin(sn) * c);
}

float cnoise(vec3 v) {
    float t = v.z * 0.3;
    v.y *= 0.8;
    float noise = 0.0;
    float s = 0.5;
    noise += (sinf(v.x * 0.9 / s + t * 10.0) + sinf(v.x * 2.4 / s + t * 15.0) + sinf(v.x * -3.5 / s + t * 4.0) + sinf(v.x * -2.5 / s + t * 7.1)) * 0.3;
    noise += (sinf(v.y * -0.3 / s + t * 18.0) + sinf(v.y * 1.6 / s + t * 18.0) + sinf(v.y * 2.6 / s + t * 8.0) + sinf(v.y * -2.6 / s + t * 4.5)) * 0.3;
    return noise;
}

float cnoise(vec2 v) {
    float t = v.x * 0.3;
    v.y *= 0.8;
    float noise = 0.0;
    float s = 0.5;
    noise += (sinf(v.x * 0.9 / s + t * 10.0) + sinf(v.x * 2.4 / s + t * 15.0) + sinf(v.x * -3.5 / s + t * 4.0) + sinf(v.x * -2.5 / s + t * 7.1)) * 0.3;
    noise += (sinf(v.y * -0.3 / s + t * 18.0) + sinf(v.y * 1.6 / s + t * 18.0) + sinf(v.y * 2.6 / s + t * 8.0) + sinf(v.y * -2.6 / s + t * 4.5)) * 0.3;
    return noise;
}

float fbm(vec3 x, int octaves) {
    float v = 0.0;
    float a = 0.5;
    vec3 shift = vec3(100);

    for (int i = 0; i < 10; ++i) {
        if (i >= octaves){ break; }

        v += a * cnoise(x);
        x = x * 2.0 + shift;
        a *= 0.5;
    }

    return v;
}

float fbm(vec2 x, int octaves) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100);
    mat2 rot = mat2(cos(0.5), sin(0.5), -sin(0.5), cos(0.50));

    for (int i = 0; i < 10; ++i) {
        if (i >= octaves){ break; }

        v += a * cnoise(x);
        x = rot * x * 2.0 + shift;
        a *= 0.5;
    }

    return v;
}
{@}texturecover.glsl{@}vec4 textureCover(sampler2D tex, vec2 meshSize, vec2 textureSize, vec2 uv) {
  vec2 s = meshSize;
  vec2 i = textureSize;

  float rs = s.x / s.y;
  float ri = i.x / i.y;
  vec2 new = rs < ri ? vec2(i.x * s.y / i.y, s.y) : vec2(s.x, i.y * s.x / i.x);
  vec2 offset = (rs < ri ? vec2((new.x - s.x) / 2.0, 0.0) : vec2(0.0, (new.y - s.y) / 2.0)) / new;
  vec2 duv = uv * s / new + offset;

  return texture2D(tex, duv);
}{@}transformUV.glsl{@}vec2 translateUV(vec2 uv, vec2 translate) {
    return uv - translate;
}

vec2 rotateUV(vec2 uv, float r, vec2 origin) {
    float c = cos(r);
    float s = sin(r);
    mat2 m = mat2(c, -s,
                  s, c);
    vec2 st = uv - origin;
    st = m * st;
    return st + origin;
}

vec2 scaleUV(vec2 uv, vec2 scale, vec2 origin) {
    vec2 st = uv - origin;
    st /= scale;
    return st + origin;
}

vec2 rotateUV(vec2 uv, float r) {
    return rotateUV(uv, r, vec2(0.5));
}

vec2 scaleUV(vec2 uv, vec2 scale) {
    return scaleUV(uv, scale, vec2(0.5));
}

vec2 skewUV(vec2 st, vec2 skew) {
    return st + st.gr * skew;
}

vec2 transformUV(vec2 uv, float a[9]) {

    // Array consists of the following
    // 0 translate.x
    // 1 translate.y
    // 2 skew.x
    // 3 skew.y
    // 4 rotate
    // 5 scale.x
    // 6 scale.y
    // 7 origin.x
    // 8 origin.y

    vec2 st = uv;

    //Translate
    st -= vec2(a[0], a[1]);

    //Skew
    st = st + st.gr * vec2(a[2], a[3]);

    //Rotate
    st = rotateUV(st, a[4], vec2(a[7], a[8]));

    //Scale
    st = scaleUV(st, vec2(a[5], a[6]), vec2(a[7], a[8]));

    return st;
}{@}TransitionShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tFrom;
uniform sampler2D tTo;
uniform float uTransition;
uniform float uType;

uniform float uFromScale;
uniform vec2 uFromOffset;
uniform vec2 uFromBorder;

uniform float uToScale;
uniform vec2 uToOffset;
uniform vec2 uToBorder;

#!VARYINGS

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment
#require(range.glsl)

float roundedBorder(float thickness, float radius, vec2 uv, vec2 resolution, out float inside) {
    // Get square-pixel coordinates in range -1.0 .. 1.0
    float multiplier = max(resolution.x, resolution.y);
    vec2 ratio = resolution / multiplier;
    vec2 squareUv = (2.0 * uv - 1.0) * ratio; // -1.0 .. 1.0

    float squareThickness = (thickness / multiplier);
    float squareRadius = 2.0 * (radius / multiplier);
    vec2 size = ratio - vec2(squareRadius + squareThickness);


    vec2 q = abs(squareUv) - size;
    float d = min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - squareRadius;
    float dist = abs(d);
    float delta = fwidth(dist);
    float border = 1.0 - smoothstep(-delta, delta, dist - squareThickness);

    delta = fwidth(d);
    float limit = squareThickness * 0.5;
    inside = 1.0 - smoothstep(-delta, delta, d - limit);

    return border;
}

float roundedBorder(float thickness, float radius, vec2 uv, vec2 resolution) {
    float inside;
    return roundedBorder(thickness, radius, uv, resolution, inside);
}

vec4 sampleBox(sampler2D map, vec2 uv, float scale, vec2 offset, float thickness, float radius) {
    vec2 newUv = uv;

    newUv += offset;
    newUv -= 0.5;
    newUv *= scale;
    newUv += 0.5;

    float inside;
    float border = roundedBorder(thickness, radius, newUv, resolution, inside);

    vec3 outColor = vec3(0.09,0.02,0.157);
    outColor = mix(outColor, texture2D(map, newUv).rgb, inside);
    
    return vec4(outColor, inside);
}

void main() {
    vec2 uv = gl_FragCoord.xy / resolution;
    vec3 color = vec3(0.0);

    vec3 purple = vec3(0.09,0.02,0.157);

    if (uType == 0.0) {
        // scale down with rounded border
        vec4 tex1 = sampleBox(tFrom, uv, uFromScale, uFromOffset, uFromBorder.x, uFromBorder.y);
        vec4 tex2 = sampleBox(tTo, uv, uToScale, uToOffset, uToBorder.x, uToBorder.y);

        color = mix(tex1.rgb, tex2.rgb, tex2.a);
    }

    if (uType == 1.0) {
        // going down
        float p = uTransition; //0-1

        float yOffset = 0.5;
        vec3 from = texture2D(tFrom, uv + vec2(0.0, -yOffset * p)).rgb;
        vec3 to = texture2D(tTo, uv + vec2(0.0, yOffset - (p * yOffset))).rgb;

        float blend = 0.6;
        from = mix(from, purple, p * blend);
        to = mix(to, purple, blend - (p * blend));

        // color = mix(from, to, rangeTransition(p, uv.y, 0.0));
        color = mix(from, to, step(uv.y, p));
    }

    if (uType == 2.0) {
        // going up
        float p = uTransition; //0-1
        float yOffset = 0.5;
        vec3 from = texture2D(tFrom, uv + vec2(0.0, yOffset * p)).rgb;
        vec3 to = texture2D(tTo, uv + vec2(0.0, -yOffset + (yOffset * p))).rgb;

        float blend = 0.6;
        from = mix(from, purple, p * blend);
        to = mix(to, purple, blend - (p * blend));

        // color = mix(from, to, rangeTransition(p, 1.0 - uv.y, 0.0));
        color = mix(from, to, step(1.0 - uv.y, p));
    }

    if (uType == 3.0) {
        // going right
        float p = uTransition; //0-1
        float xOffset = 0.0;
        vec3 from = texture2D(tFrom, uv + vec2(xOffset * p, 0.0)).rgb;
        vec3 to = texture2D(tTo, uv + vec2(-xOffset + (xOffset * p), 0.0)).rgb;

        float blend = 0.6;
        from = mix(from, purple, p * blend);
        to = mix(to, purple, blend - (p * blend));

        // color = mix(from, to, rangeTransition(p, 1.0 - uv.x, 0.0));
        color = mix(from, to, step(1.0 - uv.x, p));
    }

    if (uType == 4.0) {
        // going left
        float p = uTransition; //0-1
        float xOffset = 0.0;
        vec3 from = texture2D(tFrom, uv + vec2(-xOffset * p, 0.0)).rgb;
        vec3 to = texture2D(tTo, uv + vec2(xOffset - (xOffset * p), 0.0)).rgb;

        float blend = 0.6;
        from = mix(from, purple, p * blend);
        to = mix(to, purple, blend - (p * blend));

        // color = mix(from, to, rangeTransition(p, uv.x, 0.0));
        color = mix(from, to, step(uv.x, p));
    }

    gl_FragColor = vec4(color, 1.0);
}
{@}PlanetMonitorShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uIndex;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;

    vec3 pos = position;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#require(transformUV.glsl)

void main() {
  vec2 uv = vUv;

  vec4 color = texture2D(tMap, uv * vec2(1., 0.3333) + vec2(0., uIndex * 0.3333));

  #drawbuffer Color gl_FragColor = color;
  #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 0., 1.); 
}{@}PlanetSceneShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uMobile;
uniform vec2 uResolution;
uniform vec2 uUvParallax;
uniform float uIndex;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;

    vec3 pos = position;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

void main() {
  vec2 uvOrigin = vUv;
  vec2 uv = (gl_FragCoord.xy - 0.5 * (resolution.xy - uResolution.xy)) / uResolution.xy;
  uv -= uUvParallax;
  vec3 color = texture2D(tMap, clamp(uv, 0.0, 1.0)).rgb;


  float gradCentered =  abs(uv.x - 0.5) * 1.;

  uvOrigin += uUvParallax * 20. + 1.5;
  float angle = 0.48 + uUvParallax.x;
  vec2 centeredUv = uvOrigin - 0.5;
  float cosA = cos(angle);
  float sinA = sin(angle);
  vec2 rotUv = vec2(
    centeredUv.x * cosA - centeredUv.y * sinA,
    centeredUv.x * sinA + centeredUv.y * cosA
  ) + 0.5;

  float line = step(0.3, rotUv.x) - step(0.6, rotUv.x);
  float line2 = step(0.23, rotUv.x) - step(0.28, rotUv.x);

  color += vec3(line + line2) * 0.1 * (gradCentered * 1.8);

  #drawbuffer Color gl_FragColor = vec4(color, 1.0);
  #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 0., 1.); 
}{@}PlanetSlideShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColorVessel;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;

    vec3 pos = position;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#require(transformUV.glsl)

void main() {
  vec2 uv = vUv;
  vec2 fragUv = gl_FragCoord.xy / resolution.xy;

  vec3 color = texture2D(tMap, uv).rgb;;
  float luminance = smoothstep(0.5, 1.0, color.g) * 1.4;
  vec3 colorVessel =  uColorVessel.rgb * luminance;

  vec2 rotUv = rotateUV(fragUv - vec2(0.5, 0), -0.1);
  float line = step(0.3, rotUv.x) - step(0.33, rotUv.x) ;
  colorVessel = mix(colorVessel, vec3(0.0), color.b);
  colorVessel = mix(colorVessel, uColorVessel * 2.2, color.b * line);

  #drawbuffer Color gl_FragColor = vec4(colorVessel, 1. - color.r );
  #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 0., 1.); 
}{@}CircleDotShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform float uIdle;
// uDotParams: x = dot width (0-1), y = frequency (count), z = radial width (0-1)
uniform vec3 uDotParams;
// uAngle: x = start (0-1), y = end (0-1), z = rotation (0-1)
uniform vec3 uAngle;
uniform vec3 uColor;
uniform float uProgress;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
  vUv = uv;

  vec3 pos = position;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#require(aastep.glsl)

const float PI = 3.14159265;
const float TAU = 6.28318531;

void main() {
  vec2 uv = vUv;

  vec3 color = uColor;

  float radius = 0.08;

  float innerR = 0.5 - radius - (0.3 * (uIdle));
  float outerR = 0.5 - (radius - 0.01);
  float inside = aastep(innerR, length(uv - 0.5));
  float outside = aastep(outerR, length(uv - 0.5));

  float alpha = inside * (1.0 - outside);

  // radial position in ring (0 = inner, 1 = outer) for rectangular dot width
  float ringLen = length(uv - 0.5);
  float radialT = (ringLen - innerR) / (outerR - innerR);
  float radialMask = 1.0 - step(uDotParams.z, radialT);

  // angle in 0-1 for start/stop range, with rotation; uProgress animates reveal from start to end
  float angle = atan(uv.y - 0.5, uv.x - 0.5);
  float angle01 = fract((angle + PI) / TAU + uAngle.z);
  float start = uAngle.x;
  float end = uAngle.y;
  float endAnimated;
  if (end >= start) {
    endAnimated = mix(start, end, uProgress);
  } else {
    // arc wraps 0; animate along path start -> 1 -> 0 -> end
    float arcLen = (1.0 - start) + end;
    endAnimated = fract(start + uProgress * arcLen);
  }
  float inRange;
  if (end >= start) {
    inRange = step(start, angle01) * (1.0 - step(endAnimated, angle01));
  } else {
    // visible when angle in [start, 1] or [0, endAnimated]; nothing when progress ~0 (endAnimated ~ start)
    inRange = min(1.0, step(start, angle01) + (1.0 - step(endAnimated, angle01)));
    inRange *= step(0.001, uProgress);
  }

  // dotted line: uDotParams.x = dot width, uDotParams.y = frequency, rotation applied
  angle += uAngle.z * TAU;
  angle -= time * 0.07 + (0.3 * (uIdle));
  float dotted = step(uDotParams.x, fract(angle * uDotParams.y));

  alpha = alpha * (1.0 - dotted) * radialMask * inRange;
  alpha *= 0.5 - (0.15 * uIdle);

  #drawbuffer Color gl_FragColor = vec4(color, alpha);
  #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 1.0, 0.); 
}{@}CompassShader.glsl{@}#!ATTRIBUTES
attribute vec3 outlineid;

#!UNIFORMS
uniform sampler2D tMap;

#!VARYINGS
varying vec2 vUv;
varying vec3 vOutlineId;

#!SHADER: Vertex

void main() {
  vUv = uv;
  vOutlineId = outlineid;

  vec3 pos = position;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
void main() {
  vec2 uv = vUv;
  vec3 color = texture2D(tMap, uv).rgb;

  #drawbuffer Color gl_FragColor = vec4(color, 1.0);
  #drawbuffer Color2 gl_FragColor = vec4(vOutlineId.r, vOutlineId.g, 0., 1.0);
}{@}CompassShadow.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
  vUv = uv;
  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

void main() {
    vec3 color = uColor;

    #drawbuffer Color gl_FragColor = vec4(color, uAlpha);
    #drawbuffer Color2 gl_FragColor = vec4(1.0, 1.0, .0, uAlpha);
}{@}CrackShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uProgress;
uniform float uOffset;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
  vUv = uv;

  vec3 pos = position;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

void main() {
  vec2 uv = vUv;

  const vec2 uCenter = vec2(0., 0.5);
  vec3 color = texture2D(tMap, uv ).rgb;
  float progress = step(uProgress, color.r + color.g * 0.5 - uv.x + uOffset);
  float mask = progress;

  #drawbuffer Color gl_FragColor = vec4(vec3(mask),0.);
  #drawbuffer Color2 gl_FragColor = vec4(color.r,  color.g, mask, 1.0);
}{@}PulseShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform float uProgress;
uniform float uStrokeWidth;
uniform float uMaxRadius;
uniform float uProgressRadial;
uniform vec3 uColor;
uniform vec3 uColorRadial;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
  vUv = uv;

  vec3 pos = position;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

void main() {
  vec2 uv = vUv;
  vec2 center = vec2(0.5);
  float dist = length(uv - center);

  float halfStroke = uStrokeWidth * 0.5;
  float alpha = 0.0;

//   const float uProgress = 0.3;
//   const float uProgressRadial = 0.6;

  // First circle at uProgress, second at uProgress + 0.5 (wrapped)
  for (int i = 0; i < 2; i++) {
    float progress = (i == 0) ? uProgress : fract(uProgress + 0.5);
    float radius = progress * uMaxRadius;
    float ring = smoothstep(radius - halfStroke, radius, dist) * (1.0 - smoothstep(radius, radius + halfStroke, dist));
    float fadeIn = smoothstep(0.0, 0.15, progress);
    float fadeOut = 1.0 - smoothstep(0.7, 1.0, progress);
    alpha += ring * fadeIn * fadeOut;
  }

    // Radial gradient circle: smooth edge, bright at edge, dark at center (inset). Radius in UV scale so it stays visible.
  float smoothEdge = 0.0;
  float radiusRadial = uProgressRadial * max(uMaxRadius, 0.5);
  float inCircle = 1.0 - smoothstep(radiusRadial, radiusRadial + smoothEdge, dist);
  float radialGradient = smoothstep(0.15, radiusRadial, dist); // 0 at center (dark), 1 at edge (bright)
  float fadeInRadial = smoothstep(0.0, 0.9, uProgressRadial);
  float fadeOutRadial = 1.0 - smoothstep(0.9, 1.0, uProgressRadial);
  float circleRadial = inCircle * radialGradient * fadeInRadial * fadeOutRadial;

  alpha += circleRadial * 0.4;
  alpha = min(alpha, 1.0);
  vec3 color = mix(uColor, uColorRadial, circleRadial);
  gl_FragColor = vec4(color, alpha);
}{@}ConstellationBackgroundShader.glsl{@}#!ATTRIBUTES
attribute vec3 outlineid;

#!UNIFORMS
uniform sampler2D tMap;
uniform float uRotation;

#!VARYINGS
varying vec2 vUv;
varying vec3 vOutlineId;

#!SHADER: Vertex

mat2 rotate2D(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

void main() {
  vUv = uv;
  vOutlineId = outlineid;

  vec3 pos = position;
  pos.y -= (1.0 - uRotation) * 0.15;


  gl_Position = vec4(pos, 1.0);
}

#!SHADER: Fragment
void main() {
  vec2 uv = vUv;
  vec3 color = texture2D(tMap, uv).rgb;

  #drawbuffer Color gl_FragColor = vec4(color, 1.0);
  #drawbuffer Color2 gl_FragColor = vec4(vOutlineId.g, vOutlineId.r, 0.0, 1.0);
}{@}ConstellationFloatingShader.glsl{@}#!ATTRIBUTES
attribute vec3 outlineid;

#!UNIFORMS
uniform sampler2D tMap;
uniform float uFloat;
uniform float uRotation;

#!VARYINGS
varying vec2 vUv;
varying vec3 vOutlineId;

#!SHADER: Vertex

mat2 rotate2D(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

void main() {
    vUv = uv;
    vOutlineId = outlineid;

    vec3 pos = position;
    pos.y -= (1.0 - uRotation) * 0.12;

    float aspect = resolution.x / resolution.y;

    bool isWide = resolution.x > resolution.y;

    bool floatLeft = uFloat < 0.5;

    float scale = 2.0;

    if (floatLeft) {
        pos.x += 1.0;
        pos.x /= aspect;
        pos.x -= 1.0;
    }

    if (!floatLeft) {
        pos.x -= 1.0;
        pos.x /= aspect;
        pos.x += 1.0;
    }

    gl_Position = vec4(pos, 1.0);
}

#!SHADER: Fragment
void main() {
  vec2 uv = vUv;
  vec3 color = texture2D(tMap, uv).rgb;


  #drawbuffer Color gl_FragColor = vec4(color, 1.0);
  #drawbuffer Color2 gl_FragColor = vec4(vOutlineId.g, vOutlineId.r, 0.0, 1.0);
}{@}ConstellationGuideLineShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform float uDashPeriod;
uniform float uDashRatio;
uniform float uGuideOpacity;

#!VARYINGS

#!SHADER: Vertex
void main() {
}

#!SHADER: Fragment
void main() {
    float period = max(uDashPeriod, 0.0001);
    float s = mod(vUv2.x + time * 0.1, period);
    float dashEnd = period * clamp(uDashRatio, 0.001, 1.0);
    float fw = max(fwidth(vUv2.x), 0.0001);
    float dashMask = 1.0 - smoothstep(dashEnd - fw, dashEnd + fw, s);
    gl_FragColor.a *= dashMask;
    gl_FragColor.a *= uGuideOpacity;
}
{@}SingleStartShader.glsl{@}#!ATTRIBUTES
attribute float random;

#!UNIFORMS
uniform vec3 uColor;
uniform float uOpacity;

#!VARYINGS
varying vec2 vUv;
varying float vRandom;

#!SHADER: Vertex
void main() {
  vUv = uv;

  vec3 pos = position;
  vRandom = random;
  gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#require(simplenoise.glsl)

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
  vec2 uv = vUv;
  vec2 fragUv = gl_FragCoord.xy / resolution.xy;

  vec3 color = uColor;
  float noise = rand(fragUv + time + vRandom);
  float noise2 = cnoise(fragUv * 0.3 + time * 3. + vRandom) * 0.04;

  uv -= 0.5;
  float shape = 1. - length(uv) * 2. + noise2;
  shape += smoothstep(.2, .0, length(uv) * 1.3);
  uv += 0.5;

  #drawbuffer Color gl_FragColor = vec4(color, (shape - (noise * 0.2 - 0.1)) * uOpacity);
  #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 1.0, 1.); 
}{@}StarsShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform vec3 uColor3;
uniform float uIntensity;
uniform float uGradientFactor;
uniform float uRotation;
uniform float uTransition;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;

#!SHADER: Vertex

void main() {
    vUv = uv;

  vec3 pos = position;
  vPos = position;

  gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}


float stars(vec2 uv, float time, float size, float starSize, float twinkleTime) {
  vec2 scaledUv = uv * size;
  vec2 gv = floor(scaledUv);
  vec2 fv = fract(scaledUv);

  float star = 0.0;
  float starNoise = rand(gv);
  vec2 starPos = mix(vec2(0.2), vec2(0.8), vec2(starNoise, fract(starNoise * 34.0)));
  float d = length(fv - starPos) * starSize - starNoise * 0.05;
  float twinkle = sin(time * twinkleTime * starNoise);
  star = (smoothstep(0.9, 0., d) * (1. - twinkle * 0.2)) * .03;

  return star;
}
void main() {
  vec2 uv = vUv;
  vec2 fragUv = gl_FragCoord.xy / resolution.yy;
  fragUv.y -= uRotation * 0.1;
  fragUv.x -= uTransition * 0.1;
  vec3 color = vec3(0.);

  float grad = (vPos.y) * uGradientFactor;
  grad = max(0.0, grad);
  grad = smoothstep(0.0, 1.0, grad);
  float noise = rand(vUv + floor(fract(time) * 3.14159));
  grad += noise * 0.01;

  float band1 = smoothstep(0.0, 0.33, grad);
  float band2 = smoothstep(0.33, 0.66, grad);
  float band3 = smoothstep(0.66, 1.0, grad);

  vec3 c1 = uColor1 * (1.0 - band1);
  vec3 c2 = uColor2 * (band1 - band2);
  vec3 c3 = uColor3 * (band2);

  color = (c1 + c2 + c3) * (1.0 + uIntensity * 0.1);

  float s = stars(fragUv, time, 3., 40., 5.) * (smoothstep(0.2, 1., 1. - band1));
  color += vec3(s) * 20.0;

  #drawbuffer Color gl_FragColor = vec4(color, 1.);
  #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 1.0, 0.); 
}
{@}StarsTextureShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uIntensity;
uniform float uGradientFactor;
uniform float uRotation;
uniform float uTransition;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying float vRotationX;

#!SHADER: Vertex

void main() {
    vUv = uv;

  vec3 pos = position;
  vPos = position;

  vRotationX = modelMatrix[0].x;

  gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}


float stars(vec2 uv, float time, float size, float starSize, float twinkleTime) {
    vec2 scaledUv = uv * size;
    vec2 gv = floor(scaledUv);
    vec2 fv = fract(scaledUv);

    float star = 0.0;
    float starNoise = rand(gv);
    vec2 starPos = mix(vec2(0.2), vec2(0.8), vec2(starNoise, fract(starNoise * 34.0)));
    float d = length(fv - starPos) * starSize - starNoise * 0.05;
    float twinkle = sin(time * twinkleTime * starNoise);
    star = (smoothstep(0.9, 0., d) * (1. - twinkle * 0.2)) * .03;

    return star;
}
void main() {
    vec2 uv = vUv;
    vec2 fragUv = gl_FragCoord.xy / resolution.yy;

    float noise = rand(fragUv + floor(fract(time) * 4.0) * 3.14159);

    fragUv.y -= uRotation * 0.1;
    fragUv.x -= uTransition * 0.1;
    vec3 color = vec3(0.);

    float grad = (vPos.y) * uGradientFactor;
    grad = max(0.0, grad);
    grad = smoothstep(0.0, 1.0, grad);
    // grad += noise * 0.01;

    float band1 = smoothstep(0.0, 0.33, grad);

    //   float band2 = smoothstep(0.33, 0.66, grad);
    //   float band3 = smoothstep(0.66, 1.0, grad);

    //   vec3 c1 = uColor1 * (1.0 - band1);
    //   vec3 c2 = uColor2 * (band1 - band2);
    //   vec3 c3 = uColor3 * (band2);

    //   color = (c1 + c2 + c3) * (1.0 + uIntensity * 0.1);

    vec2 skyUv = vec2(fragUv.y, 1.0);
    skyUv.x *= mix(0.5, 1.0, uRotation);
    skyUv.x += (1.0 - uRotation) * 0.5;
    color = texture2D(tMap, skyUv).rgb;
    // color += (noise * 2.0 - 1.0) * 0.02;

    float s = stars(fragUv, time, 3., 40., 5.) * (smoothstep(0.2, 1., 1. - band1));
    color += vec3(s) * 20.0;

    #drawbuffer Color gl_FragColor = vec4(color, 1.);
    #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 1.0, 0.); 
}
{@}AsteroidShader.glsl{@}#!ATTRIBUTES
attribute vec3 outlineid;

#!UNIFORMS
uniform sampler2D tMap;
uniform float uMove;

#!VARYINGS
varying vec2 vUv;
varying vec3 vOutlineId;

#!SHADER: Vertex

mat2 rotate2D(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

void main() {
  vUv = uv;
  vOutlineId = outlineid;

  vec3 pos = position;

  // Subtle up/down movement per item
  if (uMove > 0.5) {
    pos.y += sin(time + pos.z) * 0.06;
  }

  mat4 billboardViewMatrix = viewMatrix;
  billboardViewMatrix[0][0] = 1.0;
  billboardViewMatrix[0][1] = 0.0;
  billboardViewMatrix[0][2] = 0.0;

  vec4 worldPos = modelMatrix * vec4(pos, 1.0);

  gl_Position = projectionMatrix * billboardViewMatrix * worldPos;
}

#!SHADER: Fragment
void main() {
  vec2 uv = vUv;
  vec3 color = texture2D(tMap, uv).rgb;

  // float outlineMask = 1.0 - step(0.1, vOutlineId.b);

  #drawbuffer Color gl_FragColor = vec4(color, 1.0);
  #drawbuffer Color2 gl_FragColor = vec4(vOutlineId.g, vOutlineId.r, 0., 1.0);
}{@}CrystalShader.glsl{@}#!ATTRIBUTES
attribute vec3 outlineid;
attribute vec2 uv2;

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tVoronoi;
uniform sampler2D tHitMask;
uniform float uMove;

#!VARYINGS
varying vec2 vUv;
varying vec3 vOutlineId;
varying vec2 vUv2;

#!SHADER: Vertex

mat2 rotate2D(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

void main() {
  vUv = uv;
  vUv2 = uv2;
  vOutlineId = outlineid;

  vec3 pos = position;

  // Subtle up/down movement per item
  if (uMove > 0.5) {
    pos.y += sin(time + pos.z) * 0.06;
  }

  mat4 billboardViewMatrix = viewMatrix;
  billboardViewMatrix[0][0] = 1.0;
  billboardViewMatrix[0][1] = 0.0;
  billboardViewMatrix[0][2] = 0.0;

  vec4 worldPos = modelMatrix * vec4(pos, 1.0);

  gl_Position = projectionMatrix * billboardViewMatrix * worldPos;
}

#!SHADER: Fragment
#require(transformUV.glsl)
#require(range.glsl)

void main() {
  vec2 uv = vUv;
  vec2 uv2 = vUv2;
  vec3 color = texture2D(tMap, uv).rgb;

  float hitMask = texture2D(tHitMask, uv2).r;
  float hitMaskLess = range(hitMask, 0., .5, 0., 1.);
  float hitMaskMore = range(hitMask, 0.5, 1., 0., 1.);
  vec2 cracksLess = texture2D(tVoronoi, uv2).rg * 0.5;
  vec2 cracksMore = texture2D(tVoronoi, uv2 * 2.5).rg * 0.5;
  vec2 cracks = cracksLess + (cracksMore * hitMaskMore);

  vec3 outlineBase = vec3(vOutlineId.g, vOutlineId.r, 0.0);
  vec3 cracksColor = vec3(cracks.r, cracks.g, 0.0);
  float crackInfluence = hitMaskLess * 0.4;
  vec3 blended = mix(outlineBase, cracksColor, crackInfluence);
  
  #drawbuffer Color gl_FragColor = vec4(color, 1.0);

  #drawbuffer Color2 gl_FragColor = vec4(blended.r, blended.g, 0., 1.0);
}{@}ImpactShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform float uProgress;
uniform vec3 uColor;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
  vUv = uv;

  vec3 pos = position;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#require(aastep.glsl)
#require(range.glsl)

const float PI = 3.14159265;
const float TAU = 6.28318531;

void main() {
  vec2 uv = vUv;
  vec2 center = vec2(0.5, 0.5);

  float circleRotate = 1.1;
  
  float circleProgress = uProgress;
  float circleScale = circleProgress;
  float fadeOutStart = 0.7;
  float circleFadeOut = 1.0 - clamp((circleProgress - fadeOutStart) / (1.0 - fadeOutStart), 0.0, 1.0);
  float circleFade =  circleFadeOut;

  float radiusCircle = 0.01;
  float innerR = (0.5 - radiusCircle) * circleScale;
  float outerR = (0.5 - (radiusCircle - 0.01)) * circleScale;

  // Circle
  vec2 circleOffset = uv - center;
  circleOffset.x /= max(0.01, cos(circleRotate));
  float distFromCenter = length(circleOffset);
  float inside = aastep(innerR, distFromCenter);
  float outside = aastep(outerR, distFromCenter);
  float circle = (inside * (1.0 - outside)) * circleFade;

// Dot circle
  vec2 dotCenter = center + vec2(0.1, 0.);
  vec2 dotOffset = uv - dotCenter;
  dotOffset.x /= max(0.01, cos(circleRotate));
  float distDot = length(dotOffset);
  float dotRadius = 0.25;
  float dotInnerR = (0.5 - dotRadius) * circleScale;
  float dotOuterR = (0.5 - (dotRadius - .01)) * circleScale;
  float dotInside = aastep(dotInnerR, distDot);
  float dotOutside = aastep(dotOuterR, distDot);
  float dotRing = dotInside * (1.0 - dotOutside);
  float dotAngle = atan(dotOffset.y, dotOffset.x);
  float dotFreq = 15.;
  float dotWidth = 0.45;
  float dotted = 1. - step(dotWidth, fract((dotAngle + PI) / TAU * dotFreq));
  float dottedCircle = dotRing * dotted * circleFade;

  // Glow - 3 types
  vec2 oval = vec2(0.2, 0.5);
  vec2 d = (uv - center) / oval;
  float dist = length(d);
  float dist2 = length(uv - center) * 2.1;
  float radius = 0.8;
  float soft = 1.0;
  float glow = 1.0 - smoothstep(radius - soft, radius, dist);
  float centralGlow = 1.0 - smoothstep(radius - soft, radius * 0.5, dist);
  float outerGlow = 1.0 - smoothstep(radius - soft, radius * 1.2, dist2);

  float intensity = 1.0 - uProgress;
  vec3 circleColor = vec3(1.0, 1.0, 1.0);
  vec3 baseColor = uColor + centralGlow;
  vec3 col = baseColor + (circle + dottedCircle) * (circleColor - baseColor);
  float glowAlpha = (glow * intensity * 2.0 + centralGlow + outerGlow) * intensity;
  float circleAlpha = (circle + dottedCircle) * circleFade;
  float alpha = glowAlpha + circleAlpha;
  gl_FragColor = vec4(col, alpha);
}{@}PointGlowShader.glsl{@}#!ATTRIBUTES
attribute float random;

#!UNIFORMS
uniform sampler2D tMap;

#!VARYINGS
varying vec2 vUv;
varying float vRandom;
#!SHADER: Vertex

void main() {
  vUv = uv;

  vec3 pos = position;
  pos.y += sin((time * 0.01 )  * random  * 30.) * 0.1 * random;
  pos.x += cos((time * 0.01 ) * random  * 30.) * 0.1 * random;

  float skewX = 0.3 * sin(time * 0.02 + random * 10.);
  float skewY = 0.3 * cos(time * 0.02 + random * 10.);

  pos.x += skewX * pos.y;
  pos.y += skewY * pos.x;

  vRandom = random;
  gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

void main() {
  vec2 uv = vUv;

  vec4 color = texture2D(tMap, uv).rgba * 0.7 * (1. - vRandom * .6);
  gl_FragColor = vec4(color.rgb, color.a);
}
{@}ShieldShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform float uLineRadius;
uniform float uThetaLength;
uniform vec2 uPadding;
uniform vec3 uColor;
uniform float uProgress;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
  vUv = uv;

  vec3 pos = position;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#require(range.glsl)

void main() {
  vec2 uv = vUv;
  vec3 color = uColor;

  vec2 center = vec2(0.5);
  float arcRadius = 0.5 - uPadding.y;
  float dist = length(uv - center);
  float angle = atan(uv.y - center.y, uv.x - center.x);

  float thetaHalf = uThetaLength * 0.47 * uProgress + 0.1;
  float startInset = -thetaHalf + uPadding.x;
  float endInset = thetaHalf - uPadding.x;
  vec2 startCapPt = center + arcRadius * vec2(cos(startInset), sin(startInset));
  vec2 endCapPt = center + arcRadius * vec2(cos(endInset), sin(endInset));

  float distToArc;
  if (angle >= startInset && angle <= endInset) {
    distToArc = abs(dist - arcRadius);
  } else if (angle >= -thetaHalf && angle < startInset) {
    distToArc = length(uv - startCapPt);
  } else if (angle > endInset && angle <= thetaHalf) {
    distToArc = length(uv - endCapPt);
  } else {
    distToArc = 1.0;
  }

  float lineMask = 1.0 - smoothstep(uLineRadius - 0.001, uLineRadius + 0.008, distToArc);

  lineMask *= crange(uProgress, 0.0, 0.2, 0.0, 1.0);

  #drawbuffer Color gl_FragColor = vec4(color,lineMask);
  #drawbuffer Color2 gl_FragColor = vec4(0., 0., 1., 1.); 
}{@}BaseOutlineShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uOutlineAdjust;

#!VARYINGS
varying vec2 vOutlineId;

#!SHADER: Vertex

mat2 rotate2D(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

void main() {
  vOutlineId = normal.xy * 0.5 + 0.5;

  vec3 pos = position;

  gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
void main() {
  vec3 color = uColor;
  

  #drawbuffer Color gl_FragColor = vec4(color, 1.0);
  #drawbuffer Color2 gl_FragColor = vec4(vOutlineId.g - uOutlineAdjust, vOutlineId.r + uOutlineAdjust, 0.0, 1.0);
}{@}CircleShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uType;
uniform float uTransition;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
  vUv = uv;

  vec3 pos = position;
  pos *= uTransition;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
#require(aastep.glsl)

void main() {
  vec2 uv = vUv;

  vec3 color = uColor;

  float radius = 0.01;

  if (uType == 2.0) {
    radius = 0.003;
  }

  if (uType == 3.0) {
    radius = 0.001;
  }

  float inside = aastep(0.5 - radius, length(uv - 0.5));
  float outside = aastep(0.5, length(uv - 0.5));

  float alpha = inside * (1.0 - outside);

  if (uType == 0.0) {
    alpha *= 1.5;
  }

  if (uType == 2.0) {
    // dotted line pattern

    float angle = atan(uv.y - 0.5, uv.x - 0.5);
    angle -= time * 0.04;
    float dotted = step(0.3, fract(angle * 30.0));

    alpha = alpha * (1.0 - dotted);
    alpha *= 1.2;
  }

  if (uType == 3.0) {
    alpha *= 0.9;
  }
  
  alpha *= uTransition;
  alpha *= 0.5;

  #drawbuffer Color gl_FragColor = vec4(color, alpha);
  #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 1.0, 0.01 * alpha); 
}{@}CustomText3D.glsl{@}#!ATTRIBUTES
attribute vec3 animation;

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;
uniform float uOpacity;
uniform vec3 uTranslate;
uniform vec3 uRotate;
uniform float uDirection;
uniform float uTransition;
uniform float uWordCount;
uniform float uLineCount;
uniform float uLetterCount;
uniform float uByWord;
// uniform vec4 uOffsetLine;
uniform float uByLine;
uniform float uPadding;
uniform vec3 uBoundingMin;
uniform vec3 uBoundingMax;
uniform float uSimpleAnimation;

#!VARYINGS
varying float vTrans;
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

#require(range.glsl)
#require(eases.glsl)
#require(rotation.glsl)
#require(conditionals.glsl)

void main() {
    vUv = uv;
    vTrans = 1.0;

    vec3 pos = position;

    float lineIndex = animation.z;

    // if (lineIndex == 0.0) {
    //     pos.x += uOffsetLine.x;
    // }

    // if (lineIndex == 1.0) {
    //     pos.x += uOffsetLine.y;
    // }

    // if (lineIndex == 2.0) {
    //     pos.x += uOffsetLine.z;
    // }

    // if (lineIndex == 3.0) {
    //     pos.x += uOffsetLine.w;
    // }

    if (uTransition >= 0.0 && uTransition < 1.0) {
        // float padding = uPadding;
        // float letter = (animation.x + 1.0) / uLetterCount;
        float word = (animation.y + 1.0) / uWordCount;
        float line = (animation.z + 1.0) / uLineCount;
        // float line = (animation.z + 1.0) / uLineCount;

        // float letterTrans = rangeTransition(uTransition, letter, padding);
        // float wordTrans = rangeTransition(uTransition, word, padding);
        // float lineTrans = rangeTransition(uTransition, line, padding);

        // vTrans = mix(cubicOut(letterTrans), cubicOut(wordTrans), uByWord);
        // vTrans = mix(vTrans, cubicOut(lineTrans), uByLine);

        // float invTrans = (1.0 - vTrans);
        // vec3 nRotate = normalize(uRotate);
        // vec3 axisX = vec3(1.0, 0.0, 0.0);
        // vec3 axisY = vec3(0.0, 1.0, 0.0);
        // vec3 axisZ = vec3(0.0, 0.0, 1.0);
        // vec3 axis = mix(axisX, axisY, when_gt(nRotate.y, nRotate.x));
        // axis = mix(axis, axisZ, when_gt(nRotate.z, nRotate.x));
        // pos = vec3(vec4(position, 1.0) * rotationMatrix(axis, radians(max(max(uRotate.x, uRotate.y), uRotate.z) * invTrans)));
        // pos += uTranslate * invTrans;

        float wordTrans = rangeTransition(uTransition, word, uPadding);
        // pos.y -= mix(0.1, 0.0, circularOut(wordTrans));

        vec3 center = (uBoundingMin + uBoundingMax) * 0.5;
        float distFromCenter = length(position.xy - center.xy);


        if (uSimpleAnimation > 0.5) {
            float lineTrans = rangeTransition(uTransition, line, uPadding);
            pos.y += mix(-0.1, 0.0, cubicOut(lineTrans));
            vTrans = cubicOut(lineTrans);

        } else {
            pos -= center;
            if (uDirection > 0.5) {
                pos *= mix(1.5, 1.0, circularOut(wordTrans));
            } else {
                pos *= mix(0.8, 1.0, circularOut(wordTrans));
            }
            pos += center;
            vTrans = cubicOut(wordTrans);
        }
    }

    vPos = pos;
	vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(range.glsl)
#require(msdf.glsl)
#require(simplenoise.glsl)

vec2 getBoundingUV() {
    vec2 uv;
    uv.x = crange(vPos.x, uBoundingMin.x, uBoundingMax.x, 0.0, 1.0);
    uv.y = crange(vPos.y, uBoundingMin.y, uBoundingMax.y, 0.0, 1.0);
    return uv;
}

void main() {
    float alpha = msdf(tMap, vUv);

    //float noise = 0.5 + smoothstep(-1.0, 1.0, cnoise(vec3(vUv*50.0, time* 0.3))) * 0.5;

    // gl_FragColor.rgb = uColor;
    alpha = alpha * uAlpha * uOpacity * vTrans;

    #drawbuffer Color gl_FragColor = vec4(uColor, alpha);

    // very small alpha value won't affect outlines, but can be used as a mask
    #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 1.0, 0.01 * alpha); 
}
{@}LandingBackgroundShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform vec3 uColor3;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;

#!SHADER: Vertex

mat2 rotate2D(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

void main() {
  vUv = uv;

  vec3 pos = position;
  vPos = position;

  mat4 billboardViewMatrix = viewMatrix;
  billboardViewMatrix[0][0] = 1.0;
  billboardViewMatrix[0][1] = 0.0;
  billboardViewMatrix[0][2] = 0.0;

  gl_Position = projectionMatrix * billboardViewMatrix * modelMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}


void main() {
    vec2 uv = vUv;

    float grad = vPos.x * 0.5 + 0.3 + vPos.y * 0.6;
    grad = max(0.0, grad);
    grad = smoothstep(0.0, 1.0, grad);
    float noise = rand(vUv + floor(fract(time) * 3.14159));
    grad += noise * 0.01;

    vec3 color = mix(uColor1, uColor2, grad) + uColor3 * smoothstep(0.0, 1.0, (1.0 - abs(grad - 0.5)));

    #drawbuffer Color gl_FragColor = vec4(color, 1.0);
    #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
}{@}LandingBillboardShader.glsl{@}#!ATTRIBUTES
attribute vec3 outlineid;

#!UNIFORMS
uniform sampler2D tMap;
uniform float uMove;

#!VARYINGS
varying vec2 vUv;
varying vec3 vOutlineId;

#!SHADER: Vertex

mat2 rotate2D(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

void main() {
  vUv = uv;
  vOutlineId = outlineid;

  vec3 pos = position;

  // Subtle up/down movement per item
  if (uMove > 0.5) {
    pos.y += sin(time + pos.z) * 0.06;
  }

  mat4 billboardViewMatrix = viewMatrix;
  billboardViewMatrix[0][0] = 1.0;
  billboardViewMatrix[0][1] = 0.0;
  billboardViewMatrix[0][2] = 0.0;

  vec4 worldPos = modelMatrix * vec4(pos, 1.0);

  gl_Position = projectionMatrix * billboardViewMatrix * worldPos;
}

#!SHADER: Fragment
void main() {
  vec2 uv = vUv;
  vec3 color = texture2D(tMap, uv).rgb;

  // float outlineMask = 1.0 - step(0.1, vOutlineId.b);

  #drawbuffer Color gl_FragColor = vec4(color, 1.0);
  #drawbuffer Color2 gl_FragColor = vec4(vOutlineId.g, vOutlineId.r, 0.0, 1.0);
}{@}LandingLightbeamShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor1;
uniform vec3 uColor2;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;

#!SHADER: Vertex

mat2 rotate2D(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

void main() {
  vUv = uv;

  vec3 pos = position;
  pos.x -= pos.y;

  vPos = position;

  mat4 billboardViewMatrix = viewMatrix;
  billboardViewMatrix[0][0] = 1.0;
  billboardViewMatrix[0][1] = 0.0;
  billboardViewMatrix[0][2] = 0.0;

  gl_Position = projectionMatrix * billboardViewMatrix * modelMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}


void main() {
    vec2 uv = vUv;

    // float grad = smoothstep(0.5, 0.0, length(vUv - 0.5));
    float grad = 1.0 - clamp(length(vUv - 0.5) * 2.0, 0.0, 1.0);
    grad = pow(grad, 2.0);
    grad = smoothstep(0.0, 1.0, grad);
    float noise = rand(vUv + floor(fract(time) * 3.14159));
    grad += noise * 0.01;

    vec3 color = uColor1;

    #drawbuffer Color gl_FragColor = vec4(color, 0.4 * grad);
    #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
}{@}LandingPrimitiveShader.glsl{@}#!ATTRIBUTES
attribute vec3 outlineid;

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor1;
uniform vec3 uRotationAxis;
uniform float uOpacity;

#!VARYINGS
varying vec2 vUv;
varying vec3 vOutlineId;

#!SHADER: Vertex

mat2 rotate2D(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

mat3 rotation3d(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;

    return mat3(
    oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,
    oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,
    oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c
    );
}

void main() {
    vUv = uv;
    vOutlineId = outlineid;

    vec3 pos = position;
    mat3 rotMatrix = rotation3d(uRotationAxis, time * 0.5);
    pos = rotMatrix * pos;

    pos.y += sin(time + uRotationAxis.x * 10.0 + uRotationAxis.y * 10.0) * 0.1;

    mat4 billboardViewMatrix = viewMatrix;
    billboardViewMatrix[0][0] = 1.0;
    billboardViewMatrix[0][1] = 0.0;
    billboardViewMatrix[0][2] = 0.0;

    gl_Position = projectionMatrix * billboardViewMatrix * modelMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
void main() {
  vec2 uv = vUv;
  vec3 color = texture2D(tMap, uv).rgb;

  #drawbuffer Color gl_FragColor = vec4(color, uOpacity);
  #drawbuffer Color2 gl_FragColor = vec4(vOutlineId.g * uOpacity, vOutlineId.b * uOpacity, 0.0, 1.0);
}{@}CircleShadowShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform float uProgress;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
  vUv = uv;
  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
#require(aastep.glsl)

void main() {

    vec3 color = vec3(0.0, 0.0, 0.0);

    float dist = length((vUv - 0.5) * vec2(1.0, 4.0));
    float circleMask = 1.0 - aastep(0.5, dist);
    float alpha = circleMask;
    alpha *= 0.5;

    #drawbuffer Color gl_FragColor = vec4(color, alpha);
    #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 0.0, 0.01);

}{@}DottedCircleShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform float uProgress;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
  vUv = uv;
  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
#require(aastep.glsl)

void main() {

    vec2 uv = vUv;
    uv.y += time * 0.025;

    float dottedMask = 1.0;
    dottedMask *= aastep(0.97, uv.x);
    dottedMask *= 1.0 - aastep(0.99, uv.x);
    dottedMask *= aastep(0.5, fract(uv.y * 25.0));

    // float animatedMask = sin(time) * 0.5 + 0.5;
    float animatedMask = 1.0 - uProgress;
    dottedMask *= step(0.0, vUv.y - animatedMask);

    vec3 color = vec3(1.0);
    float alpha = 1.0 * uAlpha;
    alpha *= dottedMask;

    #drawbuffer Color gl_FragColor = vec4(color, alpha);
    #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 0.0, 0.005);

}{@}ParticleBubbleShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform vec3 uColor3;
uniform float uProgress1;
uniform float uProgress2;
uniform float uAlpha;

#!VARYINGS
varying vec3 vPos;

#!SHADER: Vertex

float cubicInOut(float t) {
return t < 0.5
    ? 4.0 * t * t * t
    : 0.5 * pow(2.0 * t - 2.0, 3.0) + 1.0;
}

void main() {
    vPos = position;

    // animate scale
    vec3 pos = position;
    pos *= mix(1.1, 1.0, uProgress2);

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
void main() {
    float alpha = 0.5;

    vec2 outlineId = vec2(0.9, 0.2);

    float progress = uProgress1;

    float floorPos = -1.53;
    if (vPos.y + vPos.z * 0.15 < -0.2) discard;

    // animate mask
    if (vPos.y > progress * 1.212 - 0.2 - vPos.z * 0.15) discard;


    vec3 color = mix(uColor2, uColor1, vPos.y);
    color = pow(color, vec3(2.0));
    color += smoothstep(progress - 0.3, progress, vPos.y + vPos.z * 0.15) * (1.0 - progress) * 2.0;
    color = pow(color, vec3(0.5));

    #drawbuffer Color gl_FragColor = vec4(color, alpha);
    #drawbuffer Color2 gl_FragColor = vec4(outlineId, 0.0, 0.5);
}{@}ParticlePrimitiveShader.glsl{@}#!ATTRIBUTES
attribute vec3 outlineid;

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor1;
uniform vec3 uRotationAxis;
uniform float uOpacity;

#!VARYINGS
varying vec2 vUv;
varying vec3 vOutlineId;

#!SHADER: Vertex

mat2 rotate2D(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

mat3 rotation3d(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;

    return mat3(
    oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,
    oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,
    oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c
    );
}

void main() {
    vUv = uv;
    vOutlineId = outlineid;

    vec3 pos = position;
    mat3 rotMatrix = rotation3d(uRotationAxis, time * 0.5);
    pos = rotMatrix * pos;

    mat4 billboardViewMatrix = viewMatrix;
    billboardViewMatrix[0][0] = 1.0;
    billboardViewMatrix[0][1] = 0.0;
    billboardViewMatrix[0][2] = 0.0;

    gl_Position = projectionMatrix * billboardViewMatrix * modelMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
void main() {
  vec2 uv = vUv;
  vec3 color = texture2D(tMap, uv).rgb;

  #drawbuffer Color gl_FragColor = vec4(color, uOpacity);
  #drawbuffer Color2 gl_FragColor = vec4(vOutlineId.g * uOpacity, vOutlineId.b * uOpacity, 0.0, 1.0);
}{@}PlanetCloudShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;
varying vec3 vOutlineId;

#!SHADER: Vertex

mat2 rotate2D(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

void main() {
    vUv = uv;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(aastep.glsl)

void main() {
    vec3 color = uColor;
    float alpha = uAlpha;

    float circle = length(vUv - 0.5);
    alpha *= 1.0 - aastep(0.49, circle);

    #drawbuffer Color gl_FragColor = vec4(color, alpha);
    #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
}{@}PlanetCloudTextureShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

mat2 rotate2D(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

void main() {
    vUv = uv;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(aastep.glsl)

void main() {
    vec3 color = texture2D(tMap, vUv).rgb;
    float alpha = uAlpha;

    #drawbuffer Color gl_FragColor = vec4(color, alpha);
    #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
}{@}PlanetSkyShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform float uHorizonPos;
uniform float uSkew;
uniform float uScale;

#!VARYINGS
varying vec2 vUv;
varying vec3 vOutlineId;

#!SHADER: Vertex

mat2 rotate2D(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

void main() {
    vUv = uv;

    gl_Position = vec4(position * 2.0, 1.0); // force full screen
}

#!SHADER: Fragment
void main() {
    float y = vUv.y * uHorizonPos + (1.0 - uHorizonPos);
    y += (vUv.x - 0.5) * uSkew; 

    y -= 0.5;
    y *= uScale;
    y += 0.5;

    y = clamp(y, 0.0, 1.0);
    y = smoothstep(0.0, 1.0, y);
    
    vec3 color = mix(uColor2, uColor1, y);

    #drawbuffer Color gl_FragColor = vec4(color, 1.0);
    #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
}{@}PlanetSkyTextureShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uHorizonPos;
uniform vec2 uUvOffset;

#!VARYINGS
varying vec2 vUv;
varying vec3 vOutlineId;

#!SHADER: Vertex

mat2 rotate2D(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

void main() {
    vUv = uv;
    vec3 pos = position;

    gl_Position = vec4(pos * 2.0, 1.0); // force full screen
}

#!SHADER: Fragment
void main() {
    float y = vUv.y * uHorizonPos + (1.0 - uHorizonPos);
    vec2 uv = vec2(y, 1.0);
    uv += uUvOffset;
    vec3 color = texture2D(tMap, uv).rgb;

    #drawbuffer Color gl_FragColor = vec4(color, 1.0);
    #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
}{@}PostProcess.fs{@}#require(blendmodes.glsl)
#require(texturecover.glsl)

uniform sampler2D tMap;
uniform sampler2D tColor2;
uniform float uDPR;
uniform mat3 uInteractionSlots;
uniform mat3 uInteractionSlots2;
uniform vec3 uShockValues; // x: outer scale, y: band scale, z: displacement max
uniform float uVesselDeform;
uniform float uOverlay;

// https://ameye.dev/notes/edge-detection-outlines/
float robertsCross(vec2 uv)
{
    vec2 offset = uDPR / vec2(textureSize(tColor2, 0));
    offset *= 0.4;

    vec2 tl = texture2D(tColor2, uv + vec2(-1.0, 1.0) * offset).rg;
    vec2 tr = texture2D(tColor2, uv + vec2( 1.0, 1.0) * offset).rg;
    vec2 bl = texture2D(tColor2, uv + vec2(-1.0,  -1.0) * offset).rg;
    vec2 br = texture2D(tColor2, uv + vec2( 1.0,  -1.0) * offset).rg;

    vec2 difference_1 = tl - br;
    vec2 difference_2 = tr - bl;
    return sqrt(dot(difference_1, difference_1) + dot(difference_2, difference_2));
}

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

// https://www.shadertoy.com/view/Xsl3DH
vec2 shockPixelDelta(vec2 centerPx, vec2 uv, vec2 res, float startradius, float size, float shockfactor) {
    const float PI = 3.14159265;
    vec2 pixelpos = uv * res.xy;
    float m_distance = distance(centerPx, pixelpos);
    if (m_distance > startradius && m_distance < startradius + size) {
        float sin_dist = sin((m_distance - startradius) / size * PI) * shockfactor;
        vec2 radial = pixelpos - centerPx;
        float rlen = length(radial);
        vec2 dir = rlen > 1e-5 ? radial / rlen : vec2(0.0);
        vec2 shiftedPx = pixelpos - dir * sin_dist;
        return shiftedPx / res.xy - uv;
    }
    return vec2(0.0);
}



vec2 shockContribution(vec2 uv, vec2 res, vec3 slot) {
    float p = clamp(slot.z, 0.0, 1.0);
    if (p <= 0.0) {
        return vec2(0.0);
    }

    float R = min(res.x, res.y);
    float startradius = p * uShockValues.x * R;
    float size = max(p * uShockValues.y * R, 1.);
    float shockfactor = mix(uShockValues.z, 0., p);
    return shockPixelDelta(slot.xy * res.xy, uv, res, startradius, size, shockfactor);
}

vec2 shockwaveWarpUV(vec2 uv, vec2 res) {
    vec2 d = vec2(0.0);
    d += shockContribution(uv, res, uInteractionSlots[0]);
    d += shockContribution(uv, res, uInteractionSlots[1]);
    d += shockContribution(uv, res, uInteractionSlots[2]);
    d += shockContribution(uv, res, uInteractionSlots2[0]);
    d += shockContribution(uv, res, uInteractionSlots2[1]);
    d += shockContribution(uv, res, uInteractionSlots2[2]);
    return uv + d;
}

vec2 vesselCurveUV(vec2 uv, vec2 res) {
    float k = uVesselDeform;
    if (abs(k) < 1e-5) {
        return uv;
    }

    vec2 p = uv - 0.5;
    float aspect = res.x / max(res.y, 1.0);
    p.x *= aspect;

    float r2 = dot(p, p);
    float r4 = r2 * r2;

    float m = 1.0 + k * r2 + k * 0.35 * r4;
    p *= m;

    p.x /= aspect;
    return p + 0.5;
}

void main() {
    vec2 uvCurved = vesselCurveUV(vUv, resolution);
    vec2 uvScene = shockwaveWarpUV(uvCurved, resolution);

    float outline = robertsCross(uvScene);
    outline = 1.0 - outline;
    // outline = step(0.9, outline);
    outline = pow(outline, 3.0);
    outline = max(0.3, outline);
    // outline = smoothstep(0.0, 1.0, outline);

    // hide outline on text
    float textMask = texture2D(tColor2, uvScene).b;
    textMask = step(0.005, textMask);
    outline = mix(outline, 1.0, textMask);

    vec3 color = texture2D(tDiffuse, uvScene).rgb;
    color *= mix(1.0, outline, 0.5);

    // grain layer like figma
    vec4 overlay = textureCover(tMap, resolution, vec2(2048.0, 1498.0), vUv);
    overlay.rgb += 0.25;
    color = blendLinearBurn(color, overlay.rgb, 1.1);

    float noise = rand(gl_FragCoord.xy / resolution + floor(fract(time) * 12.1));
    noise = noise * 2.0 - 1.0;
    color += noise * 0.02;

    // color = texture2D(tColor2, vUv).rgb;

    color *= mix(1.0, 0.5, uOverlay);

    gl_FragColor = vec4(color, 1.0);
}{@}TitleShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
  vUv = uv;
  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
void main() {
  vec4 color = texture2D(tMap, vUv);  
  float alpha = color.a * uAlpha;

  #drawbuffer Color gl_FragColor = vec4(color.rgb, alpha);
  #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 1.0, 0.01 * alpha); 
}{@}VesselBeamShader.glsl{@}#!ATTRIBUTES
attribute vec3 outlineid;

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform vec3 uColor3;
uniform vec3 uHighlightPos;
uniform float uPitchAngle;
uniform float uRollAngle;
uniform float uBeamProgress;
uniform float uBeamProgress1;
uniform float uBeamProgress2;
uniform float uAlpha;

#!VARYINGS
varying vec3 vPos;
varying vec3 vWorldPos;
varying vec3 vNormal;
varying vec2 vUv;
varying float vWindowMask;
varying float vBlend;
varying vec3 vOutlineId;

#!SHADER: Vertex

mat2 rotate2D(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

float cubicInOut(float t) {
return t < 0.5
    ? 4.0 * t * t * t
    : 0.5 * pow(2.0 * t - 2.0, 3.0) + 1.0;
}

void main() {
    vUv = uv;
    vNormal = normal;
    vPos = position;
    vOutlineId = outlineid;

    vec3 pos = position;
    
    // float beamProgress = uBeamProgress;
    // beamProgress = 1.0;
    // beamProgress = sin(time) * 0.5 + 0.5;

    pos.y -= 0.5;

    // set overall height
    float height = 3.0;
    pos.y *= height;

    // separate beam progress into two parts: 0.0 -> 0.5 and 0.5 -> 1.0
    // float beamProgress1 = clamp(beamProgress * 1.25, 0.0, 1.0);
    // float beamProgress2 = clamp(beamProgress * 2.0 - 1.0, 0.0, 1.0);
    // beamProgress1 = cubicInOut(beamProgress1);
    // beamProgress2 = cubicInOut(beamProgress2);
    float beamProgress1 = uBeamProgress1;
    float beamProgress2 = uBeamProgress2;

    // animate base outwards
    float scaleBase = 8.0;
    pos.xz += clamp(-position.y, 0.0, 1.0) * pos.xz * scaleBase * beamProgress2;

    // animate downwards
    pos.y *= beamProgress1;

    // scale overall outwards
    pos.xz *= mix(0.03, 0.9, beamProgress2);

    // position just inside vessel beam opening
    pos.y -= 0.96;

    // match rotation of vessel shader
    pos.xy = rotate2D(-uPitchAngle * 0.5) * pos.xy;
    pos.yz = rotate2D(uRollAngle * 0.3) * pos.yz;

    mat4 billboardMatrix = viewMatrix;
    billboardMatrix[0][0] = 1.0;
    billboardMatrix[0][1] = 0.0;
    billboardMatrix[0][2] = 0.0;

    vec4 worldPos = modelMatrix * vec4(pos, 1.0);

    // set this to whatever the floor position is
    float floorPos = -1.53;

    // force angled display for orthographic view
    floorPos -= worldPos.z * 0.25;

    worldPos.y = max(floorPos, worldPos.y);

    gl_Position = projectionMatrix * billboardMatrix * worldPos;
}

#!SHADER: Fragment
void main() {
    vec2 uv = vUv;

    vec3 color = vec3(1.0);

    float fresnel = 1.0 - abs(vPos.z);
    fresnel = pow(fresnel, 10.0);
    float alpha = fresnel * 0.2;
    float verticalGrad = 1.0 - (vPos.y + 0.5) * 1.0;
    alpha = verticalGrad * 0.5;
    alpha += mix(1.0, verticalGrad, 0.5) * fresnel * 0.15;

    alpha = mix(1.0, alpha, uBeamProgress2);

    vec2 outlineId = vec2(0.0);
    if (vOutlineId.r > 0.499) {
        alpha *= 0.5;
        outlineId = vOutlineId.xy;
        alpha = smoothstep(0.75, -0.75, vPos.x);
    }

    alpha *= uAlpha;

    #drawbuffer Color gl_FragColor = vec4(color, alpha);
    #drawbuffer Color2 gl_FragColor = vec4(outlineId.x * 0.5, 0.0, 0.0, 0.5);
}{@}VesselBodyShader.glsl{@}#!ATTRIBUTES
attribute vec3 outlineid;
attribute float colorid;

#!UNIFORMS
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform vec3 uColor3;
uniform vec3 uBodyColor1;
uniform vec3 uBodyColor2;
uniform vec3 uShadowColor;
uniform vec3 uHighlightPos;
uniform float uHighlightStep;
uniform vec3 uWindowBaseColor;
uniform vec3 uWindowHighlightColor1;
uniform vec3 uWindowHighlightColor2;
uniform float uWindowReflectionMix;
uniform float uWindowReflectionToWhite;
uniform float uWindowGradientDir;
uniform vec2 uWindowGradientRange;
uniform float uPitchAngle;
uniform float uSpinAngle;
uniform float uRollAngle;
uniform vec3 uPosition;

#!VARYINGS
varying vec2 vUv;
varying vec3 vLightingPos;
varying vec3 vWorldPos;
varying float vWindowMask;
varying float vRingMask;
varying vec3 vOutlineId;
varying float vWindowGradient;

#!SHADER: Vertex

mat2 rotate2D(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, s, -s, c);
}

void main() {
  vUv = abs(uv);
  vOutlineId = outlineid;
  vWindowMask = colorid > 0.5 && colorid < 1.5 ? 1.0 : 0.0;
  vRingMask = colorid > 1.5 && colorid < 2.5 ? 1.0 : 0.0;

  vec3 pos = position;

  float spinAngle = uSpinAngle;
  spinAngle -= time * 0.15;

  pos.xz = rotate2D(spinAngle) * pos.xz;
  pos.xy = rotate2D(-uPitchAngle * 0.5) * pos.xy;
  pos.yz = rotate2D(uRollAngle * 0.3 - 0.15) * pos.yz;

  // Subtle rotation, helps especially on mobile to avoid beeing too static
  // pos.yz = rotate2D(sin(time * 1.0 + 0.5) * 0.05) * pos.yz;

  vLightingPos = pos - uHighlightPos;
  vec2 windowGradientUv = rotate2D(uWindowGradientDir) * vLightingPos.xy;
  vWindowGradient = (-windowGradientUv.x * 0.5 + 0.6);

  mat4 billboardViewMatrix = viewMatrix;
  billboardViewMatrix[0][0] = 1.0;
  billboardViewMatrix[0][1] = 0.0;
  billboardViewMatrix[0][2] = 0.0;

  vec4 worldPos = billboardViewMatrix * modelMatrix * vec4(pos, 1.0);
  vWorldPos = worldPos.xyz;

  gl_Position = projectionMatrix * billboardViewMatrix * modelMatrix * vec4(pos, 1.0);

}

#!SHADER: Fragment
void main() {
  vec2 uv = vUv;
  vec3 color = uBodyColor1;

  vec2 screenUv = gl_FragCoord.xy / resolution;
  float aspect = resolution.x / resolution.y;
  screenUv.x *= aspect;
  
  // stylized lighting
  float lighting = length(vLightingPos);
  float lightingMask = 1.0 - step(uHighlightStep, lighting * 0.75);
  color = mix(color, uBodyColor2, clamp(lighting * 0.75, 0.0, 1.0));
  color = mix(uShadowColor, color, lightingMask);
  color = mix(color, uColor3, vRingMask);

  vec2 windowHighlightUv = screenUv + uPosition.xy * 0.15 - 0.5;
  float diagonal = fract(windowHighlightUv.x + 0.5 + windowHighlightUv.y * 0.7);
  float stylizedWindowReflection = step(0.45, diagonal) * (1.0 - step(0.475, diagonal));
  float stylizedWindowReflection2 = step(0.5, diagonal) * (1.0 - step(0.65, diagonal));
  stylizedWindowReflection += stylizedWindowReflection2;

  vec3 windowColor = uWindowBaseColor;
  windowColor = mix(windowColor, uWindowHighlightColor2, smoothstep(uWindowGradientRange.x, uWindowGradientRange.y, vWindowGradient));
  windowColor = mix(windowColor, mix(uWindowHighlightColor1, vec3(1.0), uWindowReflectionToWhite), stylizedWindowReflection * uWindowReflectionMix);
  color = mix(color, windowColor, vWindowMask);

  #drawbuffer Color gl_FragColor = vec4(color, 1.0);
  #drawbuffer Color2 gl_FragColor = vec4(vOutlineId.r, vOutlineId.g, 0.0, 1.0);
}{@}VesselCurvedTrailShader.glsl{@}#!ATTRIBUTES
attribute vec3 currpos; 
attribute vec3 nextpos;
attribute vec3 prevpos;
attribute float random;

#!UNIFORMS
uniform float uSpeed;

#!VARYINGS
varying vec2 vUv;
varying float vSpeedFactor;

#!SHADER: Vertex
void main() {
    vUv = uv;

    mat4 m = projectionMatrix * modelViewMatrix;
    vec4 projCurrPos = m * vec4(currpos, 1.0); 
    vec4 projNextPos = m * vec4(nextpos, 1.0);
    vec4 projPrevPos = m * vec4(prevpos, 1.0);

    vec2 screenCurrPos = projCurrPos.xy / projCurrPos.w;
    vec2 screenNextPos = projNextPos.xy / projNextPos.w;
    vec2 screenPrevPos = projPrevPos.xy / projPrevPos.w;

    vec2 dir1 = normalize(screenNextPos - screenCurrPos);
    vec2 dir2 = normalize(screenCurrPos - screenPrevPos);
    vec2 tangent = normalize(dir1 + dir2);

    vec2 norm = normalize(vec2(-tangent.y, tangent.x));

    // correct for resolution
    float aspect = resolution.y / resolution.x;
    norm.x *= aspect;

    // extract y scale from orthographic projection matrix
    float yscale = projectionMatrix[1][1];

    // thickness needs to be less than 1.0 to account for idle sin hover
    float thickness = 0.92 * yscale;

    vec4 pos = projCurrPos; 
    pos.xy += norm.xy * ((uv.x - 0.5) * 2.0) * thickness;

    vSpeedFactor = smoothstep(2.0, 3.5, uSpeed);

    gl_Position = pos;
}

#!SHADER: Fragment

void main() {

    vec3 color = vec3(1.0);

    float alpha = vSpeedFactor;
    alpha *= 1.0 - vUv.y;

    float edge = smoothstep(1.0, 0.99 - pow(vUv.y, 2.0) * 0.1, abs(vUv.x - 0.5) * 2.0);
    alpha *= edge;

    alpha *= 0.75;

    #drawbuffer Color gl_FragColor = vec4(color, alpha);
    #drawbuffer Color2 gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
}{@}VesselTrailShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tNoise;
uniform vec3 uColor;
uniform vec3 uSpeed;
uniform vec3 uSpeedAdd;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
  vUv = uv;
  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
#require(range.glsl)

float parabola( float x, float k ) {
    return pow( 4.0*x*(1.0-x), k );
}

void main() {

  float speed = length(uSpeed);
  vec2 noiseUV = (gl_FragCoord.xy / resolution) * 1.4;
  noiseUV.x += uSpeedAdd.x * 0.05;
  noiseUV.y += uSpeedAdd.y * 0.05;
  vec3 noise = texture2D(tNoise, noiseUV).rgb;
  vec3 color = vec3(1.0);

  float alpha = 1.0 - smoothstep(0.2, 0.2 + speed * 0.2, vUv.x);

  float vOffset = 0.1;

  alpha *= smoothstep(0.0, vOffset, vUv.y);
  alpha *= 1.0 - smoothstep(1.0 - vOffset, 1.0, vUv.y);
  alpha *= mix(0.2, 0.18, step(0.8, noise.r));

  gl_FragColor = vec4(color, alpha);
}{@}curve3d.vs{@}uniform sampler2D tCurve;
uniform float uCurveSize;

vec2 getCurveUVFromIndex(float index) {
    float size = uCurveSize;
    vec2 ruv = vec2(0.0);
    float p0 = index / size;
    float y = floor(p0);
    float x = p0 - y;
    ruv.x = x;
    ruv.y = y / size;
    return ruv;
}

vec3 transformAlongCurve(vec3 pos, float idx) {
    vec3 offset = texture2D(tCurve, getCurveUVFromIndex(idx * (uCurveSize * uCurveSize))).xyz;
    vec3 p = pos;
    p.xz += offset.xz;
    return p;
}
{@}Line.glsl{@}#!ATTRIBUTES
attribute vec3 previous;
attribute vec3 next;
attribute float side;
attribute float width;
attribute float lineIndex;
attribute vec2 uv2;

#!UNIFORMS
uniform float uLineWidth;
uniform float uBaseWidth;
uniform float uOpacity;
uniform vec3 uColor;

#!VARYINGS
varying float vLineIndex;
varying vec2 vUv;
varying vec2 vUv2;
varying vec3 vColor;
varying float vOpacity;
varying float vWidth;
varying float vDist;
varying float vFeather;
varying float vLengthScale;


#!SHADER: Vertex

//params

vec2 fix(vec4 i, float aspect) {
    vec2 res = i.xy / i.w;
    res.x *= aspect;
    return res;
}

void main() {
#test RenderManager.type == RenderManager.VR
    float aspect = (resolution.x / 2.0) / resolution.y;
#endtest
#test RenderManager.type != RenderManager.VR
    float aspect = resolution.x / resolution.y;
#endtest

    vUv = uv;
    vUv2 = uv2;
    vLineIndex = lineIndex;
    vColor = uColor;
    vOpacity = uOpacity;
    vFeather = 0.1;

    vec3 pos = position;
    vec3 prevPos = previous;
    vec3 nextPos = next;
    float lineWidth = 1.0;
    //main

    //startMatrix
    mat4 m = projectionMatrix * modelViewMatrix;
    vec4 finalPosition = m * vec4(pos, 1.0);
    vec4 pPos = m * vec4(prevPos, 1.0);
    vec4 nPos = m * vec4(nextPos, 1.0);
    //endMatrix

    vec2 currentP = fix(finalPosition, aspect);
    vec2 prevP = fix(pPos, aspect);
    vec2 nextP = fix(nPos, aspect);

    float w = uBaseWidth * uLineWidth * width * lineWidth;
    vWidth = w;

    vec4 temp1 = vec4(0.0, 0.0, pos.z, 1.0);
    temp1 = m * temp1;
    vec4 temp2 = vec4(1.0, 0.0, pos.z, 1.0);
    temp2 = m * temp2;
    vLengthScale = abs(temp2.x - temp1.x);

    vec2 dirNC = currentP - prevP;
    vec2 dirPC = nextP - currentP;
    if (length(dirNC) >= 0.0001) dirNC = normalize(dirNC);
    if (length(dirPC) >= 0.0001) dirPC = normalize(dirPC);
    vec2 dir = normalize(dirNC + dirPC);

    //direction
    vec2 normal = vec2(-dir.y, dir.x);
    normal.x /= aspect;
    normal *= 0.5 * w;

    vDist = finalPosition.z / 10.0;

    finalPosition.xy += normal * side;
    gl_Position = finalPosition;
}

#!SHADER: Fragment

//fsparams

void main() {
    float d = (1.0 / (5.0 * vWidth + 1.0)) * vFeather * (vDist * 5.0 + 0.5);
    vec2 uvButt = vec2(0.0, vUv.y);
    float buttLength = 0.5 * vWidth;
    uvButt.x = min(0.5, vUv2.x * vLengthScale / buttLength) + (0.5 - min(0.5, (vUv2.y - vUv2.x) * vLengthScale / buttLength));
    float round = length(uvButt - 0.5);
    float alpha = 1.0 - smoothstep(0.45, 0.5, round);

    /*
        If you're having antialiasing problems try:
        Remove line 93 to 98 and replace with
        `
            float signedDist = tri(vUv.y) - 0.5;
            float alpha = clamp(signedDist/fwidth(signedDist) + 0.5, 0.0, 1.0);

            if (w <= 0.3) {
                discard;
                return;
            }

            where tri function is

            float tri(float v) {
                return mix(v, 1.0 - v, step(0.5, v)) * 2.0;
            }
        `

        Then, make sure your line has transparency and remove the last line
        if (gl_FragColor.a < 0.1) discard;
    */

    vec3 color = vColor;

    gl_FragColor.rgb = color;
    gl_FragColor.a = alpha;
    gl_FragColor.a *= vOpacity;

    //fsmain

    if (gl_FragColor.a < 0.1) discard;
}
{@}SceneLayout.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vec3 pos = position;
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = texture2D(tMap, vUv);
    gl_FragColor.a *= uAlpha;
    gl_FragColor.rgb /= gl_FragColor.a;
}{@}GLUIShape.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS

#!SHADER: Vertex
void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = vec4(uColor, uAlpha);
}{@}GLUIShapeBitmap.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tMask;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = texture2D(tMap, vUv) * texture2D(tMask, vUv).a;
    gl_FragColor.a *= uAlpha;
}{@}Text3D.glsl{@}#!ATTRIBUTES
attribute vec3 animation;

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;
uniform float uOpacity;
uniform vec3 uTranslate;
uniform vec3 uRotate;
uniform float uTransition;
uniform float uWordCount;
uniform float uLineCount;
uniform float uLetterCount;
uniform float uByWord;
// uniform vec4 uOffsetLine;
uniform float uByLine;
uniform float uPadding;
uniform float uDirection;
uniform vec3 uBoundingMin;
uniform vec3 uBoundingMax;
uniform float uSimpleAnimation;

#!VARYINGS
varying float vTrans;
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

#require(range.glsl)
#require(eases.glsl)
#require(rotation.glsl)
#require(conditionals.glsl)

void main() {
    vUv = uv;
    vTrans = 1.0;

    vec3 pos = position;

    if (uTransition > 0.0 && uTransition < 1.0) {
        float padding = uPadding;
        float letter = (animation.x + 1.0) / uLetterCount;
        float word = (animation.y + 1.0) / uWordCount;
        float line = (animation.z + 1.0) / uLineCount;

        float letterTrans = rangeTransition(uTransition, letter, padding);
        float wordTrans = rangeTransition(uTransition, word, padding);
        float lineTrans = rangeTransition(uTransition, line, padding);

        vTrans = mix(cubicOut(letterTrans), cubicOut(wordTrans), uByWord);
        vTrans = mix(vTrans, cubicOut(lineTrans), uByLine);

        float invTrans = (1.0 - vTrans);
        vec3 nRotate = normalize(uRotate);
        vec3 axisX = vec3(1.0, 0.0, 0.0);
        vec3 axisY = vec3(0.0, 1.0, 0.0);
        vec3 axisZ = vec3(0.0, 0.0, 1.0);
        vec3 axis = mix(axisX, axisY, when_gt(nRotate.y, nRotate.x));
        axis = mix(axis, axisZ, when_gt(nRotate.z, nRotate.x));
        pos = vec3(vec4(position, 1.0) * rotationMatrix(axis, radians(max(max(uRotate.x, uRotate.y), uRotate.z) * invTrans)));
        pos += uTranslate * invTrans;
    }

    vPos = pos;
	vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(range.glsl)
#require(msdf.glsl)
#require(simplenoise.glsl)

vec2 getBoundingUV() {
    vec2 uv;
    uv.x = crange(vPos.x, uBoundingMin.x, uBoundingMax.x, 0.0, 1.0);
    uv.y = crange(vPos.y, uBoundingMin.y, uBoundingMax.y, 0.0, 1.0);
    return uv;
}

void main() {
    float alpha = msdf(tMap, vUv);

    //float noise = 0.5 + smoothstep(-1.0, 1.0, cnoise(vec3(vUv*50.0, time* 0.3))) * 0.5;

    gl_FragColor.rgb = uColor;
    gl_FragColor.a = alpha * uAlpha * uOpacity * vTrans;
}
{@}TweenUILPathFallbackShader.glsl{@}#!ATTRIBUTES
attribute float speed;

#!UNIFORMS
uniform vec3 uColor;
uniform vec3 uColor2;
uniform float uOpacity;

#!VARYINGS
varying vec3 vColor;

#!SHADER: Vertex

void main() {
    vColor = mix(uColor, uColor2, speed);
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vColor, uOpacity);
}
{@}TweenUILPathShader.glsl{@}#!ATTRIBUTES
attribute float speed;

#!UNIFORMS
uniform vec3 uColor2;

#!VARYINGS

#!SHADER: Vertex

void main() {
    vColor = mix(uColor, uColor2, speed);
}

void customDirection() {
    // Use screen space coordinates for final position, so line thickness is
    // independent of camera.
    finalPosition = vec4(currentP.x / aspect, currentP.y, min(0.0, finalPosition.z), 1.0);
}

#!SHADER: Fragment
float tri(float v) {
    return mix(v, 1.0 - v, step(0.5, v)) * 2.0;
}

void main() {
    float signedDist = tri(vUv.y) - 0.5;
    gl_FragColor.a *= clamp(signedDist/fwidth(signedDist) + 0.5, 0.0, 1.0);
}
