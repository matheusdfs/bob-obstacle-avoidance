function [minLeft, minMid, minRight] = look_around(ir_sensor, ir_motor) 
    %output array com 3 values minimos of quadrante "esquerdo" "meio" e "direita"
    angleMessage = rosmessage('std_msgs/UInt16');
    angleMessage.Data = 0;

    DELTA_ANGLE = 60;

    distances = [0 , 0, 0];

    for i = 0:2
        angleMessage.Data = i * DELTA_ANGLE;

        send(ir_motor, angleMessage);

        distance = receive(ir_sensor);
        
        distances[i] = distance;
    end
end