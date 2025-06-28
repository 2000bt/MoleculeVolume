%%运用跨立实验判断线段是否相交
%%快速排斥实验
%改变——相交于端点pass,根据条件判断是否重合
function[P]=Func_CrossingTest(Line_1x,Line_1y,Line_2x,Line_2y)
% Line_1x=[0;100];
% Line_1y=[0;0];
% Line_2x=[0;100];
% Line_2y=[0;0];
Flag=0;
P=[];
if((max(Line_2x)<min(Line_1x))||(max(Line_1x)<min(Line_2x))||(max(Line_2y)<min(Line_1y))||(max(Line_1y)<min(Line_2y)))
    return;
else
    %%第二阶段
    Cross_P1=Func_CrossProduct(Line_1x(1)-Line_2x(1),Line_2x(2)-Line_2x(1),Line_1y(1)-Line_2y(1),Line_2y(2)-Line_2y(1));
    Cross_P2=Func_CrossProduct(Line_1x(2)-Line_2x(1),Line_2x(2)-Line_2x(1),Line_1y(2)-Line_2y(1),Line_2y(2)-Line_2y(1));
    Cross_P3=Func_CrossProduct(Line_2x(1)-Line_1x(1),Line_1x(2)-Line_1x(1),Line_2y(1)-Line_1y(1),Line_1y(2)-Line_1y(1));
    Cross_P4=Func_CrossProduct(Line_2x(2)-Line_1x(1),Line_1x(2)-Line_1x(1),Line_2y(2)-Line_1y(1),Line_1y(2)-Line_1y(1));
%     Cross_P1=(Line_1x(1)-Line_2x(1))*(Line_2y(2)-Line_2y(1))-(Line_2x(2)-Line_2x(1))*(Line_1y(1)-Line_2y(1));%ca cd
%     Cross_P2=(Line_1x(2)-Line_2x(1))*(Line_2y(2)-Line_2y(1))-(Line_2x(2)-Line_2x(1))*(Line_1y(2)-Line_2y(1));%cd cb
%     Cross_P3=(Line_2x(1)-Line_1x(1))*(Line_1y(2)-Line_1y(1))-(Line_1x(2)-Line_1x(1))*(Line_2y(1)-Line_1y(1));%ac ab
%     Cross_P4=(Line_2x(2)-Line_1x(1))*(Line_1y(2)-Line_1y(1))-(Line_1x(2)-Line_1x(1))*(Line_1y(2)-Line_2y(1));%ab ad
    if((Cross_P1*Cross_P2)<=0.00001&&(Cross_P3*Cross_P4)<=0.00001)
        %算交点
%         s_u=Func_CrossProduct(Line_2x(1)-Line1x(1),Line_2y(1)-Line1y(1),Line_1x(2)-Line1x(1),Line_1y(2)-Line1y(1));
%         s_d=Func_CrossProduct(Line_1x(2)-Line1x(1),Line_1y(2)-Line1y(1),Line_2x(2)-Line_2x(1),Line_2y(2)-Line_2y(1));
%         x=Line_2x(1)+(s_u/s_d)*(Line_2x(2)-Line_2x(1));
%         y=Line_2y(1)+(s_u/s_d)*(Line_2y(2)-Line_2y(1));
        Flag=1;
%         count1=count1+1
    else
        return;
    end
end

turn=0;
if(Flag==1)
    are123=Func_abs_area(Line_2x(1),Line_2y(1),Line_1x(1),Line_1y(1),Line_1x(2),Line_1y(2));
    are124=Func_abs_area(Line_2x(2),Line_2y(2),Line_1x(1),Line_1y(1),Line_1x(2),Line_1y(2));
    if((are123==0)&&(are124==0))
        if(Line_1x(1)==Line_1x(2))
            [S_1,I1]=sort(Line_1y);
            [S_2,I2]=sort(Line_2y);
            S_3=Line_1x(I1);
            S_4=Line_2x(I2);
            turn=1;
        else
            [S_1,I1]=sort(Line_1x);
            [S_2,I2]=sort(Line_2x);
            S_3=Line_1y(I1);
            S_4=Line_2y(I2);
        end
        P(1,1)=S_1(1);
        P(1,2)=S_3(1);
        P(2,1)=S_1(2);
        P(2,2)=S_3(2);
        if(S_1(1)<S_2(1))
            P(1,1)=S_2(1);
            P(1,2)=S_4(1);
        end
        if(S_1(2)>S_2(2))
            P(2,1)=S_2(2);
            P(2,2)=S_4(2);
        end
        if(P(1,1)==P(2,1))
            P(2,:)=[];
        end
        if(turn==1)
           temp=P(:,1);
           P(:,1)=P(:,2);
           P(:,2)=temp;
        end
    elseif(are123==0)
        P(1,1)=Line_2x(1);
        P(1,2)=Line_2y(1);
    elseif(are124==0)
        P(1,1)=Line_2x(2);
        P(1,2)=Line_2y(2);
    else
        k=are123/are124;
        P(1,1)=(Line_2x(1)+k*Line_2x(2))/(1+k);
        P(1,2)=(Line_2y(1)+k*Line_2y(2))/(1+k);
    end
   
end
end
    



