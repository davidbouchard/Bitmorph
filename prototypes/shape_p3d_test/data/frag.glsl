#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform float fade;

varying vec4 vertColor;

void main() {
  gl_FragColor = vec4(vertColor.xyz * fade, 1*fade);
}