% Lab 1 - Question 4
% 3-bit rounding uniform quantizer

function output = quantizer3bit(y)
    y_quantized = zeros(length(y),1);
    for i = 1:length(y)
        if y(i) <= -0.875
            y_quantized(i) = -1;
        elseif y(i) <= -0.625
            y_quantized(i) = -0.75;
        elseif y(i) <= -0.375
            y_quantized(i) = -0.5;
        elseif y(i) <= -0.125
            y_quantized(i) = -0.25;
        elseif y(i) <= 0.125
            y_quantized(i) = 0;
        elseif y(i) <= 0.375
            y_quantized(i) = 0.25;
        elseif y(i) <= 0.625
            y_quantized(i) = 0.5;
        elseif y(i) > 0.625
            y_quantized(i) = 0.75;
        end
    end
    output = y_quantized;
end