%% 1. Point sampling of a sinusoid:
signal = ['A','B','C','D','E','F'];
amplitude = [5,5,5,5,5,5];
frequency = [10,25,40,60,40,60];
phase = [0,0,0,0,pi/2,pi/2];
for i = 1:length(signal)
    A = amplitude(i);
    f = frequency(i);
    phi = phase(i);
    F_s = 100;
    T_s = 1/F_s;
    n = 1:0.5/T_s;
    t = n*T_s;
    x = A*cos(2*pi*f*t+phi);
    
    figure;
    stem(n,x);
    title(signal(i)+" - Amplitude "+A+", Frequency "+f+" Hz - Phase "+phi+" rad - Sampled at "+F_s+" Hz");
    xlabel('n');
    ylabel('x[n]');
end

%% 2. Working with unit impulses and unit step
% (a)
n = 1:30;
unit_impulse = [zeros(1,15),1,zeros(1,14)];
unit_step = [zeros(1,11),ones(1,19)];

figure;
stem(n,unit_impulse);
title('Unit Impulse Signal delta[n-16]');
xlabel('n');
ylabel('x[n]');

figure;
stem(n,unit_step);
title('Unit Step Signal u[n-12]');
xlabel('n');
ylabel('x[n]');

% (b)
unit_step_n_minus_14 = [zeros(1,13),ones(1,17)];
unit_step_n_minus_15 = [zeros(1,14),ones(1,16)];
x_1 = unit_step_n_minus_14 - unit_step_n_minus_15;

figure;
stem(n,x_1);
title('Unit Step Signal Difference u[n-14]-u[n-15]');
xlabel('n');
ylabel('x[n]');

% (c)
unit_step_n_minus_9 = [zeros(1,8),ones(1,22)];
unit_step_n_minus_16 = [zeros(1,15),ones(1,15)];
x_2 = unit_step_n_minus_9-unit_step_n_minus_16;

figure;
stem(n,x_2);
title('Unit Step Signal Difference u[n-9]-u[n-16]');
xlabel('n');
ylabel('x[n]');


%% 3. Complex signals
% (a)
n = 1:40;
A = 1;
omega = pi/10;
x = A*exp(1j*omega*n);

figure;
plot(real(x),imag(x)); % discrete points or continuous?
title('x[n] in Complex Plane')
xlabel('Re(x[n])');
ylabel('Im(x[n])');

% (b)
figure;
subplot(2,1,1);
stem(n,real(x));
title('Real Part of x[n]')
xlabel('n');
ylabel('Re(x[n])');
subplot(2,1,2);
stem(n,imag(x));
title('Imaginary Part of x[n]')
xlabel('n');
ylabel('Im(x[n])');

% (c)
figure;
subplot(2,1,1);
stem(n,abs(x));
title('Magnitude of x[n]')
xlabel('n');
ylabel('|x[n]|');
subplot(2,1,2);
stem(n,angle(x));
title('Phase of x[n]')
xlabel('n');
ylabel('angle(x[n])');

%% 4. Quantization of a speech signal
% (a)
[y,fs] = audioread('defineit.wav');

% (b)
n = 1:length(y);
figure;
plot(n,y);
title('defineit.wav Speech Waveform')
xlabel('n');
ylabel('y[n]');

figure;
histogram(y,50);
title('Histogram of Amplitude')
xlabel('Amplitude');
ylabel('Count');

info = audioinfo('defineit.wav')

% (c)
soundsc(y,fs)

%% (d)
% see quantizer_3_bit.m

% (e)
scale_factor = max(abs(y));
y_scaled = y / scale_factor;

% (f)
y3bits = quantizer_3_bit(y_scaled);

figure;
plot(n,y3bits);
title('defineit.wav Speech Waveform - Quantized - 3 bits')
xlabel('n');
ylabel('y3bits[n]');

figure;
histogram(y3bits,50);
title('Histogram of Amplitude - Quantized Signal')
xlabel('Amplitude');
ylabel('Count');

soundsc(y3bits*scale_factor,fs)

e = y_scaled - y3bits;

figure;
plot(n,e); % why does this look so weird?
title('Quantization Error')
xlabel('n');
ylabel('e[n]');

figure;
histogram(e,50);
title('Histogram of Quantization Error')
xlabel('Error');
ylabel('Count');

% describe in terms of standard statistical model of quantization noise?

%% (g)
scale = 10000;
y_pclip = y * scale;

y3bit_pclip = quantizer_3_bit(y_pclip);

figure;
plot(n,y3bit_pclip);
title('defineit.wav Speech Waveform - Quantized with Peak Clipping - 3 bits')
xlabel('n');
ylabel('y3bit_pclip[n]');

figure;
histogram(y3bit_pclip,50);
title('Histogram of Amplitude - Quantized with Peak Clipping')
xlabel('Amplitude');
ylabel('Count');

soundsc(y3bit_pclip/scale,fs)

e_pclip = y_pclip - y3bit_pclip;

figure;
plot(n,e_pclip); % why does this look so weird?
title('Quantization Error - With Peak Clipping')
xlabel('n');
ylabel('e_pclip[n]');

figure;
histogram(e_pclip,50);
title('Histogram of Quantization Error - With Peak Clipping')
xlabel('Error');
ylabel('Count');

% describe in terms of standard statistical model of quantization noise?