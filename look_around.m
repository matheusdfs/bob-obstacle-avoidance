function [s1, s2, s3] = look_around(ir_sensor, ir_motor) %output array com 3 values minimos of quadrante "esquerdo" "meio" e "direita"
    angle = 0;
    angleMessage = rosmessage('std_msgs/UInt16');
    DELTA_ANGLE = 5;

    distances = [];

    while angle < 115
        send(ir_motor, angleMessage);

        distance = receive(ir_sensor);
        distances.append(distances.data);
        angle = angle+  DELTA_ANGLE;    
        angleMessage = angleMessage + DELTA_ANGLE;


    end
    disp(distances);
end