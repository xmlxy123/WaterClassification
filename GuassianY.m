function Gy=GuassianY(sigma)
weight = 2*sigma*sigma;  
Gy=zeros(3,3);
sumy=0;
for i=1:3
    for j=1:3
        Gy(i,j)=(exp(-(i^2+j^2)/weight)/(pi*weight))*(-j*2/weight);
        sumy=sumy+Gy(i,j);
    end
end
Gy=Gy/sumy;
end