function d=dadil(x,y,ffGX,ffIX)

m=size(x,1);
n=size(y,1);

D = zeros(m,n);
    for i=1:n
          i
       %ed=chi_square_statistics(x(1,:),y(i,:));
       ed2=histogram_intersection(x(1,:),y(i,:))
     
     %mtch=corrMatchingDemo(x(1,:),y(i,:))
     %mtch=max(normxcorr2(x(1,:),y(i,:)));
        %ed=sum(abs((x(1,:)-y(i,:))));
        %s=sum(x(1,:));
       corr = pdist2(x(1,:),y(i,:), 'correlation')
       cos = pdist2(x(1,:),y(i,:), 'cosine')
hmm = pdist2(x(1,:),y(i,:), 'hamming')



chii=chi_square_statistics(x(1,:),y(i,:))

    
        %df=pdist2(x(1,:),y(i,:),'cosine');
        %df1=histogram_intersection(x(1,:),y(i,:));
       
        if  chii<15000 && cos<.6
            disp 'hi'
           d=.01+.2*rand(1,1);
           D(:,i)=.1;
        else
           d=.9+.2*rand(1,1);
            D(:,i)=.98;
        end
    end
