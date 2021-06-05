function [outarg] = pixel(arg)

img = arg;
[row,col] = size(img);
cm_len = 27;
in_len = cm_len/2.54; %cm to inch
dpi = col/in_len;
len = 25.4/dpi; %length of 1 pixel

outarg = len; %returns the length of one pixel

end

