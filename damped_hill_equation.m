function [dy_dt] = damped_hill_equation(t,y,a,b,f)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
dy_dt = [y(2); -(f*f*(1+b*cos(a*t))*y(1)+2*0.2*y(2))];
end

