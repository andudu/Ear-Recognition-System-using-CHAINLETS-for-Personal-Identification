mx=.8+.2*rand(7442,9500);
for i=0:179
mx(10*i+1:10*i+10,10*i+1:10*i+10)=.2*rand(10,10);
end
for i=1:1800
mx1(i,i+1)=.001*rand(1,1);
end
mx(1801:1887,1801:1887)=.2*rand(87,87);
mx(1888:7442,1888:7442)=.2*rand(5555,5555);
for i=1:7442
for j=1:size(indx)
mx(i,indx(j))=.8+.2*rand(1,1);
end
end