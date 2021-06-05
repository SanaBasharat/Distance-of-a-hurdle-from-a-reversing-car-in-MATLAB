function A = areaofobj(I1)
    % get image size
    [r1, c1] = size(I1);

    % get labelled image
    ILabel = labelobjs(I1);

    A = zeros(50, 1, 'uint32');
    for r = 1 : r1
        for c = 1 : c1
            if ILabel(r, c) ~= 0
                A(ILabel(r, c)) = A(ILabel(r, c)) + 1;
            end
        end
    end
end