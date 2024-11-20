clc
clear all

%random = randi ([1,25]);
%Y(random) = NaN;
for j= 1:25

% X Data for 
X = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25];
%Take Y out of comment for whichever vessel want to compute 
%RICA 
% Y = [240.1432,224.1086,228.242,218.2689,230.213,246.5856, 254.94, 263.155, 239.4188, 234.2248, 235.3426, 231.8853,252.826,254.221, 249.9195,240.7137,245.9703, 252.0551,251.4273,249.7621,255.3782,258.206,255.6948,242.9387,251.912]; % Corresponding Y-values
% RVA 
%Y= [134.737,125.0554,123.4529,115.6851,124.9964,125.3667,133.1774,134.9946,123.9036,118.4699,123.3617,119.4751,128.9367,135.0858,139.3676,141.4138,148.1513,150.8896,148.9347,139.7683,140.5982,137.0389,137.8885,133.8928,133.2972];
% LVA
%Y = [44.8146,41.4467,44.0169,43,41.2535,43.5608,42.0727,42.6772,44.3978,39.2145,45.1168,43.8738,45.555,45.9002,46.5262,51.2552,51.8633,53.7252,46.9197,47.9946,49.1841,49.3879,50.3252,50.2232,47.1272];
%LICA
%Y= [183.5186,169.1456,175.7204,174.6688,181.9268,183.3577,187.4213,185.647,179.7823,173.288,179.3083,174.9746,186.4,182.9463,178.0527,186.3553,192.3274,198.7966,193.6563,181.6192,189.2886,187.1888,185.9046,186.5127,202.0912]
Y = [603.2134,559.7563,571.4321,553.6144,578.3897,598.8707,617.6114,626.4738,587.5025,565.1972,583.1294,570.205,613.7177,618.1533,613.8661,619.738,638.3124,655.4666,640.938,619.1442,634.449,631.8216,629.8131,613.5674,634.4276];
Y(j) = NaN;

% Find missing Y-values
missingValue = isnan(Y);
validIndices = find(~isnan(Y));

% Interpolate missing values
for i = find(missingValue)   
   if i < 2  % if x(1)=NaN
     
      firstValue = interp1(X(validIndices(1:2)), Y(validIndices(1:2)), X(1), 'linear', 'extrap');
     Y(1:validIndices(1)-1) = firstValue; 
      
   elseif i > 24 % if x(last)=NaN
     lastValue = interp1(X(validIndices(end-1:end)), Y(validIndices(end-1:end)), X(end), 'linear', 'extrap');
     Y(validIndices(end)+1:end) = lastValue; 
  
   else
    % Find nearest X-values
    leftIndex = find(X < X(i), 1, 'last');
    rightIndex = find(X > X(i), 1, 'first');
   
    % Perform linear interpolation
    interpolatedY = interp1([X(leftIndex), X(rightIndex)], [Y(leftIndex), Y(rightIndex)], X(i), 'linear');

    % Replace missing Y-value with interpolated value
    Y(i) = interpolatedY;
end
Y_interp(j,1) = Y(i);
end
    end
disp(Y_interp); 
