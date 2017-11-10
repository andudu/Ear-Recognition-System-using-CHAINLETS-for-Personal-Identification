function f=CHAINLETS(x1,X1)
BW = uint8(x1);


BW1=~x1;

[B,L,N,A] = bwboundaries(BW1);
imshow(BW1); hold on;
colors=['b' 'g' 'r' 'c' 'm' 'y'];
for k=1:length(B),
boundary = B{k};
cidx = mod(k,length(colors))+1;
plot(boundary(:,2), boundary(:,1),...
colors(cidx),'LineWidth',2);
end
cd('/Users/elshibaniomar/Documents/MATLAB/CHAINLETS')
f = uerc_features_extract(X1);
cd ('/Users/elshibaniomar/Documents/MATLAB/demo-check')

end