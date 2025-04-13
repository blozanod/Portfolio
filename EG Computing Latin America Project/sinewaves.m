% Parameters
f = 10;  % Frequency of the sine waves (Hz)
T = 1;   % Duration (seconds)
fs = 1000; % Sampling frequency (samples per second)

% Time vector from 0 to T seconds
t = 0:1/fs:T;

% Define three sine waves 120 degrees apart
y1 = sin(2*pi*f*t);
y2 = 2*sin(2*pi*f*t + 2*pi/3);
y3 = 3*sin(2*pi*f*t + 4*pi/3);

% Sum of the three sine waves
y_sum = y1 + y2 + y3;

% Plot the individual sine waves
figure;
subplot(4,1,1);
plot(t, y1);
title('Wave 1');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,1,2);
plot(t, y2);
title('Wave 2');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,1,3);
plot(t, y3);
title('Wave 3');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot the sum of the sine waves
subplot(4,1,4);
plot(t, y_sum, 'r');
title('Sum of Waves');
xlabel('Time (s)');
ylabel('Amplitude');
