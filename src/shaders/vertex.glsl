uniform float uSize;
uniform float uTime;
uniform float uSpeed;
uniform int atanValue01;
uniform int atanValue02;
uniform int lengthParam;

attribute float aSacle;
attribute vec3 aRandomness;

varying vec3 vColor;

void main() {
   /**
   * Position
   */
   vec4 modelPosition = modelMatrix * vec4(position, 1.);
   // Spin
   float atanFirstParam = modelPosition.x;
   float atanSecondParam = modelPosition.z;
   vec2 lengthParameter = modelPosition.xz;


   if (atanValue01 == 0) {
      atanFirstParam = modelPosition.x;
   } else if (atanValue01 == 1) {
      atanFirstParam = modelPosition.y;
   } else if (atanValue01 == 2) {
      atanFirstParam = modelPosition.z;
   }

   if (atanValue02 == 0) {
      atanSecondParam = modelPosition.x;
   } else if (atanValue02 == 1) {
      atanSecondParam = modelPosition.y;
   } else if (atanValue02 == 2) {
      atanSecondParam = modelPosition.z;
   }

   if (lengthParam == 0) {
      lengthParameter = modelPosition.xz;
   } else if (lengthParam == 1) {
      lengthParameter = modelPosition.xy;
   } else if (lengthParam == 2) {
      lengthParameter = modelPosition.xx;
   } else if (lengthParam == 3) {
      lengthParameter = modelPosition.yz;
   } else if (lengthParam == 4) {
      lengthParameter = modelPosition.yy;
   } else if (lengthParam == 5) {
      lengthParameter = modelPosition.zz;
   }


   float angle = atan(atanFirstParam, atanSecondParam);

   float distaceToCenter = length(lengthParameter);
   float angleOffset = (1.0 / distaceToCenter) * uTime * uSpeed;
   angle += angleOffset;
   modelPosition.x = cos(angle) * distaceToCenter;
   modelPosition.z = sin(angle) * distaceToCenter;

   modelPosition.xyz += aRandomness;

   vec4 viewPosition = viewMatrix * modelPosition; 
   vec4 projectionPosition = projectionMatrix * viewPosition;
   gl_Position = projectionPosition;

   /**
   * Size
   */
   gl_PointSize = uSize;
   gl_PointSize *= ( 1. / - viewPosition.z );

   /**
      Colors
   */
   vColor = color;
}