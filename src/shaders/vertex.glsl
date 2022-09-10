uniform float uSize;
uniform float uTime;

attribute float aSacle;
attribute vec3 aRandomness;

varying vec3 vColor;

void main() {
   /**
   * Position
   */
   vec4 modelPosition = modelMatrix * vec4(position, 1.);
   // Spin
   float angle = atan(modelPosition.x, modelPosition.z);
   float distaceToCenter = length(modelPosition.xz);
   float angleOffset = (1.0 / distaceToCenter) * uTime * 0.2;
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