ir_sensor = rossubscriber('/bob/ir_sensor');

ir_motor = rospublisher('/bob/ir_motor');

twitst = rosmessage('geometry_msgs/Twist');

while 1
    look_around(ir_sensor, ir_motor);
end