function img2 = labelobjs(I1)
    [r1, c1] = size(I1);
    img1 = zeros(r1, c1, 'uint8');
    count = 1;
    for r = 1 : r1
        for c = 1 : c1
            if I1(r, c) ~= 0
                if r-1 > 0 && c-1 > 0 && I1(r, c) == I1(r-1, c-1)
                    img1(r, c) = img1(r-1, c-1);
                else
                    if c-1 > 0 && I1(r, c) == I1(r, c-1)
                        if r-1 > 0 && I1(r, c) == I1(r-1, c)
                            if img1(r, c-1) == img1(r-1, c)
                                img1(r, c) = img1(r, c-1);
                            else
                                img1(r, c) = img1(r-1, c);
                                for x = 1 : r1
                                    for y = 1 : c1
                                        if img1(x, y) ==  img1(r, c-1)
                                            img1(x, y) = img1(r-1, c);
                                        end
                                    end
                                end
                            end
                        else
                            img1(r, c) = img1(r, c-1);
                        end
                    else
                        if r-1 > 0 && I1(r, c) == I1(r-1, c)
                            img1(r, c) = img1(r-1, c);
                        else
                            img1(r, c) = count;
                            count = count + 1;
                        end
                    end
                end
            end
        end
    end
    
    img2 = zeros(r1, c1, 'uint8');
    count2 = 1;
    for r = 1 : r1
        for c = 1 : c1
            if img1(r, c) ~= 0 && img2(r, c) == 0
                
                for x = 1 : r1
                    for y = 1 : c1
                        if img1(x, y) == img1(r, c)
                            img2(x, y) = count2;
                        end
                    end
                end
                count2 = count2 + 1;
            end
        end
    end
end
