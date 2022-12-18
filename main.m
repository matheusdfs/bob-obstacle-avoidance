%subscribers
ir_sensor = rossubscriber('/bob/ir_sensor');

left_encoder = rossubscriber('/bob/raw/left_ticks');

right_encoder = rossubscriber('/bob/raw/right_ticks');

%publishers
ir_motor = rospublisher('/bob/ir_motor');

cmd_vel = rospublisher('/bob/cmd_vel');

%messages
twist = rosmessage('geometry_msgs/Twist');

%classes
position = PositionClass();

while 1
    % look_around(ir_sensor, ir_motor);

    [x, y, theta] = execute(position, right_encoder, left_encoder);

    disp(x);
    disp(y);
    disp(theta);
    disp('--------------------------------');

    twist.Linear.X = 1;
    
    send(cmd_vel, twist);
    
    pause(2);
end