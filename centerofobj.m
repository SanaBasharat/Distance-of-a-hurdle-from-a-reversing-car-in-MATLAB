function coord1 = centerofobj(I1)
    % get image size
    [r1, c1] = size(I1);

    % get labelled image
    ILabel = labelobjs(I1);
    coord1 = zeros(50, 2, 'uint32');

    % get center of area
    for r = 1 : r1
        for c = 1 : c1
            if ILabel(r, c) ~= 0
                coord1(ILabel(r, c), 1) = coord1(ILabel(r, c), 1) + r;
                coord1(ILabel(r, c), 2) = coord1(ILabel(r, c), 2) + c;
            end
        end
    end


    A = areaofobj(I1);
    % divide by area
    for k = 1 : 50
        if coord1(k, 1) ~= 0 || coord1(k, 2) ~= 0
            coord1(k, 1) = coord1(k, 1) / A(k);
            coord1(k, 2) = coord1(k, 2) / A(k);
        end
    end
end