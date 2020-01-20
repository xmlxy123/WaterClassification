function Gx=GuassianX(sigma)
weight = 2*sigma*sigma;  
Gx=zeros(3,3);
sumx=0;
for i=1:3
    for j=1:3
        Gx(i,j)=(exp(-(i^2+j^2)/weight)/(pi*weight))*(-i*2/weight);
        sumx=sumx+Gx(i,j);
    end
end
Gx=Gx/sumx;
end