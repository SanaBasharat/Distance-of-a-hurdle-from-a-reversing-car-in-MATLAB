function newimg = dilation(BW)
[x,y]=size(BW);
    newimg = zeros(x,y);
    mask = [[0,1,0;1,1,1;0,1,0]];
    numones = 5;
    BW = padarray(BW,1);
    for i=2:x
      for j=2:y
        %if(mask(2,2)*BW(i,j)==1)%if we get 1 at the origin
            sums = 0;
            for m=-1:1
                for n=-1:1
                    if (i+m>1 && i+m<=x && j+n>1 && j+n<=y)
                        sums = sums + (BW(i+m,j+n)*mask(2+m,2+n));
                    end
                end
            end
            if sums>=1
               newimg(i,j) = 1; % change all 
               newimg(i-1,j) = 1;
               newimg(i+1,j) = 1;
               newimg(i,j-1) = 1;
               newimg(i,j+1) = 1;
            end
        %end
      end
    end