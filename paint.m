Gaborsetting;
[ GaborReal, GaborImg ]  =  MakeAllGaborKernal( par.ke_h, par.ke_w ,par.Gabor_num,par.Kmax, par.f, par.sigma);

f1 = hsv('E:\\water\\1\\clean_433_3.jpg',GaborReal, GaborImg);
f2= hsv('E:\\water\\1\\polluted_005_10.jpg',GaborReal, GaborImg);

a1=f1(1:4,:);
a2=f2(1:4,:);
b1=f1(4:8,:);
b2=f2(4:8,:);
c1=f1(8:12,:);
c2=f2(8:12,:);
res1=zeros(4,8);
res2=zeros(4,8);
for i=1:8
    for j=1:4
        res1(j,i)=sum(a1(j,:)>=(i-1)*32 & a1(j,:)<i*32);
        res2(j,i)=sum(a2(j,:)>=(i-1)*32 & a2(j,:)<i*32);
    end
end
bes1=zeros(4,8);
bes2=zeros(4,8);
for i=1:8
    for j=1:4
        bes1(j,i)=sum(b1(j,:)>=(i-1)*32 & b1(j,:)<i*32);
        bes2(j,i)=sum(b2(j,:)>=(i-1)*32 & b2(j,:)<i*32);
    end
end

ces1=zeros(4,8);
ces2=zeros(4,8);
for i=1:8
    for j=1:4
        ces1(j,i)=sum(c1(j,:)>=(i-1)*32 & c1(j,:)<i*32);
        ces2(j,i)=sum(c2(j,:)>=(i-1)*32 & c2(j,:)<i*32);
    end
end

x=1:32;
y=0:550;
y1=reshape(res1,1,32);
y2=reshape(res2,1,32);
figure(1)
plot(x,y1,'-b',x,y2,'--r')
legend({'clean water','polluted water'},'FontSize',14); 
axis([0 35 0 500]);
% plot(x,res1,'-b',x,res2,'- -r')
hold on;

y1=reshape(bes1,1,32);
y2=reshape(bes2,1,32);
figure(2)
plot(x,y1,'-b',x,y2,'--r')
legend({'clean water','polluted water'},'FontSize',14); 
axis([0 35 0 500]); 
hold on;  

y1=reshape(ces1,1,32);
y2=reshape(ces2,1,32);
figure(3)
plot(x,y1,'-b',x,y2,'--r')
axis([0 35 0 500]); 
legend({'clean water','polluted water'},'FontSize',14); 