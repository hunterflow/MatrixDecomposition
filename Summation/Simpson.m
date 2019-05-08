function [I] = Simpson(x,y)
% Created on: April 16, 2019
% By: Hunter Flowers 

% Simpson - this function numerically evaluates the integral of the vector
% of function values 'y' with respect to 'x'
%    Inputs:
%        x - a vector of 'x' values over a desired range of integration corresponding to a function
%        y - a vector of 'y' values over a desired range of integration corresponding to a function
%    Outputs:
%        I - the integral of the 'y' inputs with respect to the 'x' inputs

%Error check to ensure input vectors are of equal length
if length(x)~= length(y)
    error('The vector inputs x and y must be the same length.')
end

%Error check to ensure more than one value was inputted into each vector
if length(x) <= 1 || length(y) <= 1
    error('The vector inputs must be longer than 1.')
end

%Create an equaly spaced x vector to check input spacing
n = length(x);
space = linspace(x(1),x(n),n);

%To account for subtractive cancellation, differences smaller than machine
%epsilon will be considered equal
if abs(space - x) > eps
    error('The x input must be equally spaced.')
end

%Divide length by 2 to determine if even or odd # of vector values
num = rem(n,2);
simpson = 0;

%If odd # of vector values only Simpson's 1/3 rule will apply
if num ~= 0
    %Generate loop length based on input length (3 length = 1 loop) 
    for i = 1:(floor((n-1)/2))
        simpson = simpson + ((((y(2*i-1))+(4*(y(2*i)))+(y(2*i+1)))*((x(2*i+1))-(x(2*i-1))))/6);
        %Trapezoidal does not contribute with odd # of vector values
        trapezoidal = 0;
    end
end

%If even # of vector values Simpson's 1/3 and the trapezoidal rules apply
if num == 0 
    for i = 1:(floor((n-1)/2))
         simpson = simpson + ((((y(2*i-1))+(4*(y(2*i)))+(y(2*i+1)))*((x(2*i+1))-(x(2*i-1))))/6);
    end
    %Trapezoidal rule is used on the last interval of the vector values
    trapezoidal = ((x(n))-(x(n-1)))*(((y(n))+(y(n-1)))/2);
    %Warn user the trapezoidl rule is used
    disp('The trapezoidal rule was used on the last interval.')
end

%Sum the Simpson's 1/3 and Trapezoidal contriutions to produce output
I = simpson + trapezoidal

end
