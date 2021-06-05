function [outarg] = distance(arg,a1,a2)
image = arg;
c1 = a1;
c2 = a2;
ans = c2 - c1;
if(ans<0)
    ans = ans*-1;
end
    outarg = ans;
end

