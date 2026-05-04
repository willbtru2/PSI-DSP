% Connect to Arduino
s = serialport("COM3", 115200);

% Buffers
time = [];
s1 = [];
s2 = [];

% Parameters
threshold = 50;   % adjust based on lighting
window = 5;       % moving average window

figure;

while true
    line = readline(s);
    data = str2double(split(line, ","));
    
    if length(data) == 3
        t = data(1);
        v1 = data(2);
        v2 = data(3);
        
        time(end+1) = t;
        s1(end+1) = v1;
        s2(end+1) = v2;
        
        % Apply moving average filter
        if length(s1) > window
            s1_f = movmean(s1, window);
            s2_f = movmean(s2, window);
            
            % Detect motion direction
            if s1_f(end) > threshold && s2_f(end) > threshold
                if find(s1_f > threshold, 1) < find(s2_f > threshold, 1)
                    direction = "Left -> Right";
                else
                    direction = "Right -> Left";
                end
                disp("Motion: " + direction);
            end
            
            % Plot
            plot(time, s1_f, 'r', time, s2_f, 'b');
            legend('Sensor 1', 'Sensor 2');
            xlabel('Time (ms)');
            ylabel('Intensity');
            drawnow;
        end
    end
end
