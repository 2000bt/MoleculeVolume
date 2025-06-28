% syms x1 x2 x3 x4 y1 y2 y3 y4;
% k=((x2-x1)*(y3-y1)-(y2-y1)*(x3-x1))/((x2-x1)*(y4-y1)-(y2-y1)*(x4-x1));
% x_1=x3+x4*k;
% x1=x_1/(1+k)
% 
% 
% d=(y2-y1)*(x4-x3)-(y4-y3)*(x2-x1);
% x_2=(x2-x1)*(x3*y4-y4*x3)-(x4-x3)*(x1*y2-x2*y1);
% x2=x_2/d

% A=[2,7;3,6;1,9];
% C=[9,1];
% ismember(C,A,'rows');
% [C,I]=sort(A);
% idx=find(I==max(I));
% C(idx);
% B=[3;6;4];
% B=B(I);
% P=[2,1;3,4];
% temp=P(:,1);
% P(:,1)=P(:,2);
% P(:,2)=temp;
% P(2,:)=[];
% tic
%  len=length(mLine)-1;
%  len1=length(mLine1)-1;
% count=1;
% Point=[1000,2];
%  for i=1:len
%      L1x(1)=vXtemp(mLine(i,1));
%      L1x(2)=vXtemp(mLine(i,2));
%      L1y(1)=vYtemp(mLine(i,1));
%      L1y(2)=vYtemp(mLine(i,2));
%      for j=1:len1
%          L2x(1)=vXtemp1(mLine1(j,1));
%          L2x(2)=vXtemp1(mLine1(j,2));
%          L2y(1)=vYtemp1(mLine1(j,1));
%          L2y(2)=vYtemp1(mLine1(j,2));
%          [P]=Func_CrossingTest(L1x,L1y,L2x,L2y);
%          if(~isempty(P))
%            Point(count,:)=P;
%            count=count+1;
%          end
%            
%      end
%  end

%  toc    
% L1x(1)=vXtemp(mLine(236,1))
% L1x(2)=vXtemp(mLine(236,2))
% L1y(1)=vYtemp(mLine(236,1))
% L1y(2)=vYtemp(mLine(236,2))
% L2x(1)=vXtemp1(mLine1(414,1))
% L2x(2)=vXtemp1(mLine1(414,2))
% L2y(1)=vYtemp1(mLine1(414,1))
% L2y(2)=vYtemp1(mLine1(414,2))
% Func_CrossingTest(L1x,L1y,L2x,L2y);
% 创建一个示例矩阵
% 示例线段，每行表示一个线段，[x1, y1, x2, y2]
% even=[];
% A=[0,0];
% even=[even;A,'A(1)''A(2)']
% intersections(4,:)=[];
% 创建 Intersection 对象
% intersections=[];
% x_value = 10;
% y_value = 20;
% segment1_num_value = 1;
% segment2_num_value = 2;
% 
% inter = Intersection(x_value, y_value, segment1_num_value, segment2_num_value);

% i=Intersection(1.0,2.9,3,4)
% intersections=[intersections;inter];
% ismembertol(intersection, intersections)
% intersection(1,1)==intersections(3,1);
% eps=0.00001;
% y1=intersection(1);
% y2=intersections(3,1);
% abs(y1-y2)<eps
% A=[2,1;4.511237126117059,-11.308341127367239;4.6,2.3];
% B=[4.511237126117059,-11.308341127367239];
% ismember(B,A,'rows')

polygon1 = polyshape(vXtemp, vYtemp);
polygon2 = polyshape(vXtemp1, vYtemp1);
hold on;
plot(polygon1, 'FaceColor', 'r');
plot(polygon2, 'FaceColor', 'b');
% 使用 polybool 函数计算两个多边形的交集
[x_inter, y_inter] = polybool('intersection', vXtemp, vYtemp, vXtemp1, vYtemp1);
plot(x_inter, y_inter, 'g', 'LineWidth', 2);
hold off;

% temp=543;
% temp1=544;
% 
% intersection=Func_CrossingTest_S([segments(temp).start_x,segments(temp).end_x],[segments(temp).start_y,segments(temp).end_y],[segments(temp1).start_x,segments(temp1).end_x],[segments(temp1).start_y,segments(temp1).end_y]);