function D2=pd(X,Y)
M = size(X,2) ;
N = size(Y,2) ;
D = size(X,1) ;

D2 = zeros(M,N) ;
for d = 1:D
 X(d,:)'
 ones(1,N)
 X(d,:)'*ones(1,N)
 ones(M,1)
 Y(d,:)
 ones(M,1)*Y(d,:)
 (X(d,:)'*ones(1,N) - ones(M,1)*Y(d,:))
 (X(d,:)'*ones(1,N) - ones(M,1)*Y(d,:)).^2
  D2 = D2 + (X(d,:)'*ones(1,N) - ones(M,1)*Y(d,:)).^2 
end
