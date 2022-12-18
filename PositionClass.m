classdef PositionClass
   properties
      xPosition = 0
   end

   properties
      yPosition = 0
   end

   properties
      % In radians
      Orientation = pi / 2
   end

   properties (Constant)
      THICKS_PER_CYCLE = 32
   end

   properties (Constant)
      LENGTH_BETWEEN_WHEELS = 12.1
   end

   properties (Constant)
      RADIUS = 6.9 / 2
   end

   properties
      previousLeftEncoderCounts = 0
   end

   properties
      previousRightEncoderCounts = 0
   end

   properties
      previousTime = 0
   end

   methods
      % This method is called every frame
      function [x, y, theta] = execute(obj, rightEncoderObj, leftEncoderObj)
         re = receive(rightEncoderObj);
         le = receive(leftEncoderObj);

         rightEncoder = re.Data;
         leftEncoder = le.Data;

         obj.previousTime = clock;
         currentTime = clock;

         deltaTime = etime(currentTime, obj.previousTime);

         distancePerCount = 2 * pi * obj.RADIUS / obj.THICKS_PER_CYCLE;

         deltaLeft = leftEncoder - obj.previousLeftEncoderCounts;
         deltaRight = rightEncoder - obj.previousRightEncoderCounts;

         leftVelocity = deltaLeft * distancePerCount / deltaTime;
         rightVelocity = deltaRight * distancePerCount / deltaTime;

         vx = (leftVelocity + rightVelocity) / 2;
         % For Theta, anticlockwise is positive and clockwise is negative
         vth = (rightVelocity - leftVelocity) / obj.LENGTH_BETWEEN_WHEELS;

         deltaX = vx * cos(vth) * deltaTime;
         deltaY = vx * sin(vth) * deltaTime;
         deltaTheta = vth * deltaTime;

         obj.xPosition = obj.xPosition + deltaX;
         obj.yPosition = obj.yPosition + deltaY;
         obj.Orientation = obj.Orientation + deltaTheta;

         x = obj.xPosition;
         y = obj.yPosition;
         theta = obj.Orientation;

         % End of the method
         obj.previousTime = currentTime;
         obj.previousLeftEncoderCounts = leftEncoder;
         obj.previousRightEncoderCounts = rightEncoder;

         disp(deltaLeft);
         disp(deltaRight);
      end
   end
end
