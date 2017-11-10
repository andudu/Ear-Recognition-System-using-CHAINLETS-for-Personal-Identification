function frame2=adilthin(f)
frame2 = f;

%Code for spesific images
%frame2(:,200:end) = [];
%frame2 = rgb2gray(frame2);

%Make binary
frame2(frame2 < 128) = 1;
frame2(frame2 >= 128) = 0;

%Get sizes and set up mark
[Yn Xn] = size(frame2);
markMatrix = zeros(Yn,Xn);

%First visualization
%figure();imagesc(frame2);colormap(gray)
%%

%While loop control
cc = 0; 
changed = 1;
while changed && cc < 50;

    changed = 0;
    cc = cc + 1;
    markMatrix = zeros(Yn,Xn);

    for x = 2:1:Xn-1
        for y = 2:1:Yn-1

            % if this pixel is not black, then, proceed in.
            if (frame2(y,x) > 0)                

                % the pos(2 to 9) here are for the surrounding pixels.
                pos(1) = frame2(y,   x);
                pos(2) = frame2(y-1, x);
                pos(3) = frame2(y-1, x+1);
                pos(4) = frame2(y,   x+1);
                pos(5) = frame2(y+1, x+1);
                pos(6) = frame2(y+1, x);
                pos(7) = frame2(y+1, x-1);
                pos(8) = frame2(y,   x-1);
                pos(9) = frame2(y-1, x-1);

                nonZeroNeighbor = 0;
                transitSequence = 0;
                change = pos(9);

                for n = 2:1:9

                    %N()
                    nonZeroNeighbor = sum(pos(2:end));

                    %S()
                    if (double(pos(n)) - double(change)) < 0
                        transitSequence = transitSequence + 1;
                    end
                    change = pos(n);

                end

                %Test if pixel is to be removed
                if ~( nonZeroNeighbor == 0 || nonZeroNeighbor == 1 ...
                    ||nonZeroNeighbor == 7 || nonZeroNeighbor == 8 ...
                    ||transitSequence >= 2)

                        markMatrix(y,x) = 1;
                        fprintf(1, '(%d,%d) nonzero: %d transit: %d\n', ...
                            y,x, nonZeroNeighbor, transitSequence);
                end

            end
        end
    end

    %Mask out all pixels found to be deleted
    frame2(markMatrix > 0) = 0;

    %Check if anything has changed
    if sum(markMatrix(:)) > 0;changed = 1;end

end

%Final visualization
%figure();imagesc(frame2);colormap(gray)
end