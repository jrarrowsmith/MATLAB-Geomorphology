function [alpha] = ripenPBR(alpha0,duration, R)
%decrease PBR alpha from aplpha0 by R*duration

alpha=alpha0-R.*duration;
end

