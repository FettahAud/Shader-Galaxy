varying vec3 vColor;

void main(){
   // float strength = distance(gl_PointCoord, vec2(0.5));
   // strength = 1. - step(0.5, strength);

   // float strength = distance(gl_PointCoord, vec2(0.5));
   // strength = 1. - strength * 2.;
   
   float strength = distance(gl_PointCoord, vec2(0.5));
   strength = 1. - strength;
   strength = pow(strength, 10.);
   
   vec3 color = mix(vec3(0.0), vColor, strength);

   gl_FragColor = vec4(color, 1.);
}