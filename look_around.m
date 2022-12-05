function [s1, s2, s3] = look_around(ir_sensor, ir_motor) %output array com 3 values minimos of quadrante "esquerdo" "meio" e "direita"
    angleMessage = rosmessage('std_msgs/UInt16');
    angleMessage.Data = 0;
    DELTA_ANGLE = 5;

    distances = [];

    while angleMessage.Data < 115
        send(ir_motor, angleMessage);

        distance = receive(ir_sensor);
        % distances.append(distances.data);  
        angleMessage.Data = angleMessage.Data + DELTA_ANGLE;
    end
end