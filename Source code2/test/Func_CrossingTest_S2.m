%%���ÿ���ʵ���ж��߶��Ƿ��ཻ
%%�����ų�ʵ��
%�ı䡪���ཻ�ڶ˵�pass,���������ж��Ƿ��غ�
function[segments,events,count]=Func_CrossingTest_S(temp,temp1,segments,events,count)
% Line_2x=[0;0];
% Line_2y=[0;2];
% Line_1x=[-3;3];
% Line_1y=[0;2];
Line_2x=[segments(temp1).start_x,segments(temp1).end_x];
Line_2y=[segments(temp1).start_y,segments(temp1).end_y];
Line_1x=[segments(temp).start_x,segments(temp).end_x];
Line_1y=[segments(temp).start_y,segments(temp).end_y];
% Flag=0;
P=[];
if((max(Line_2x)<min(Line_1x))||(max(Line_1x)<min(Line_2x))||(max(Line_2y)<min(Line_1y))||(max(Line_1y)<min(Line_2y)))
    return;
else
    %%�ڶ��׶�
    Cross_P1=Func_CrossProduct(Line_1x(1)-Line_2x(1),Line_2x(2)-Line_2x(1),Line_1y(1)-Line_2y(1),Line_2y(2)-Line_2y(1));
    Cross_P2=Func_CrossProduct(Line_1x(2)-Line_2x(1),Line_2x(2)-Line_2x(1),Line_1y(2)-Line_2y(1),Line_2y(2)-Line_2y(1));
    Cross_P3=Func_CrossProduct(Line_2x(1)-Line_1x(1),Line_1x(2)-Line_1x(1),Line_2y(1)-Line_1y(1),Line_1y(2)-Line_1y(1));
    Cross_P4=Func_CrossProduct(Line_2x(2)-Line_1x(1),Line_1x(2)-Line_1x(1),Line_2y(2)-Line_1y(1),Line_1y(2)-Line_1y(1));
    if((Cross_P1*Cross_P2)<0&&(Cross_P3*Cross_P4)<0)
        %�㽻��
%         Flag=1;
        are123=Func_abs_area(Line_2x(1),Line_2y(1),Line_1x(1),Line_1y(1),Line_1x(2),Line_1y(2));
        are124=Func_abs_area(Line_2x(2),Line_2y(2),Line_1x(1),Line_1y(1),Line_1x(2),Line_1y(2));
        k=are123/are124;
        intersection(1)=(Line_2x(1)+k*Line_2x(2))/(1+k);
        intersection(2)=(Line_2y(1)+k*Line_2y(2))/(1+k);
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp).end_x,segments(temp).end_y,segments(temp).poly,false,false,-1)];
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp1).end_x,segments(temp1).end_y,segments(temp1).poly,false,false,-1)];
        segments(temp).end_x=intersection(1);
        segments(temp).end_y=intersection(2);
        segments(temp1).end_x=intersection(1);
        segments(temp1).end_y=intersection(2);
        %�ı�events,��������
        old_e=find(events(:,3)==temp);
        old_e1=find(events(:,3)==temp1);
        events(old_e,3)=count;
        events=[events;intersection(1),intersection(2),temp,-2];
        events=[events;intersection(1),intersection(2),temp1,-2];
        events=[events;intersection(1),intersection(2),count,-1];
        count=count+1;
        events(old_e1,3)=count;
        events=[events;intersection(1),intersection(2),count,-1];
        count=count+1;
        events=Func_SortEvents(events);
        return;
    elseif (Cross_P1*Cross_P2)==0&&(Cross_P3*Cross_P4)<0
        %���ڵ�һ���߶ζ˵� 
        are134=Func_abs_area(Line_1x(1),Line_1y(1),Line_2x(1),Line_2y(1),Line_2x(2),Line_2y(2));
%         are234=Func_abs_area(Line_1x(2),Line_1y(2),Line_2x(1),Line_2y(1),Line_2x(2),Line_2y(2));
%         Flag=2;
       %A
        if are134 == 0
            intersection=[Line_1x(1),Line_1y(1)];
        %B
        else
             intersection=[Line_1x(2),Line_1y(2)];
        end
         %�����߶�1A�˵�
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp1).end_x,segments(temp1).end_y,segments(temp1).poly,false,false,-1)];
        segments(temp1).end_x=intersection(1);
        segments(temp1).end_y=intersection(2);
        
        old_e1=find(events(:,3)==temp1);
        events(old_e1,3)=count;
        events=[events;intersection(1),intersection(2),temp1,-2];
        events=[events;intersection(1),intersection(2),count,-1];
        events=Func_SortEvents(events); 
        count=count+1;
        return;
    elseif (Cross_P1*Cross_P2)<0&&(Cross_P3*Cross_P4)==0
    %����һ���߶���
        are123=Func_abs_area(Line_2x(1),Line_2y(1),Line_1x(1),Line_1y(1),Line_1x(2),Line_1y(2));
%         are124=Func_abs_area(Line_2x(2),Line_2y(2),Line_1x(1),Line_1y(1),Line_1x(2),Line_1y(2));
        %C
%         Flag=3;
        if are123 == 0
             intersection=[Line_2x(1),Line_2y(1)];
        %D
        else
             intersection=[Line_2x(2),Line_2y(2)];
        end     
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp).end_x,segments(temp).end_y,segments(temp).poly,false,false,-1)];
        segments(temp).end_x=intersection(1);
        segments(temp).end_y=intersection(2);
        
        old_e=find(events(:,3)==temp);
        events(old_e,3)=count;
        events=[events;intersection(1),intersection(2),temp,-2];
        events=[events;intersection(1),intersection(2),count,-1];
        events=Func_SortEvents(events); 
        count=count+1;
        return;
    elseif((Cross_P1*Cross_P2)==0&&(Cross_P3*Cross_P4)==0)
         if(Cross_P1==0)&&(Cross_P2==0)
             sortline={};
             
             result1=sort_line(segments(temp).start_x,segments(temp).start_y,segments(temp1).start_x,segments(temp1).start_y);
             result2=sort_line(segments(temp).end_x,segments(temp).end_y,segments(temp1).end_x,segments(temp1).end_y);
            
             switch result1
                 case 0
                     sortline{end+1}=0;
                 case 1
                     sortline{end+1}=temp1;
                     sortline{end+1}=temp;
                 case 2
                     sortline{end+1}=temp;
                     sortline{end+1}=temp1;
             end
             switch result2
                 case 0  
                     sortline{end+1}=0;
                 case 1
                     sortline{end+1}=temp1;
                     sortline{end+1}=temp;
                 case 2
                     sortline{end+1}=temp;
                     sortline{end+1}=temp1; 
             end
             
             if size(sortline,2)==2 %�غ�
                 segments(temp).non_con=0;
                 if(segments(temp).inOut==segments(temp1).inOut)
                     segments(temp1).non_con=1;
                 else
                     segments(temp1).non_con=0;
                 end
                 return;
             elseif size(sortline,2)==3 %��һ���˵�
                 segments(sortline{2}).non_con=0;
                 if sortline{1}==0
                     %��AC
%                      segments(sortline{2}).non_con=0;
                     segments=[segments;Segment(segments(sortline{2}).end_x,segments(sortline{2}).end_y,segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{3}).poly,false,false,-1)];
                     segments(sortline{3}).end_x=segments(sortline{2}).end_x;
                     segments(sortline{3}).end_y=segments(sortline{2}).end_y;
                     
                     %�ı�events
                    old_e=find(events(:,3)==sortline{3});
                    events(old_e,3)=count;
                    events=[events;segments(sortline{2}).end_x,segments(sortline{2}).end_y,sortline{3},-2];   
                    events=[events;segments(sortline{2}).end_x,segments(sortline{2}).end_y,count,-1];
                    
                    if(segments(temp).inOut==segments(temp1).inOut)
                       segments(sortline{3}).non_con=1;
                    else
                       segments(sortline{3}).non_con=0;
                    end
                    count=count+1;
                    events=Func_SortEvents(events); 
                    
                    return;
                 else
                     %��BD,��������ϸ��
                     
                     segments=[segments;Segment(segments(sortline{2}).start_x,segments(sortline{2}).start_y,segments(sortline{2}).end_x,segments(sortline{2}).end_y,segments(sortline{1}).poly,false,false,-1)];
                     segments(sortline{1}).end_x=segments(sortline{2}).start_x;
                     segments(sortline{1}).end_y=segments(sortline{2}).start_y;
                     
                     %�ı�events
                    old_e=find(events(:,3)==sortline{1});
                    events(old_e,3)=count;
                    events=[events;segments(sortline{2}).start_x,segments(sortline{2}).start_y,sortline{1},-2];   
                    events=[events;segments(sortline{2}).start_x,segments(sortline{2}).start_y,count,-1];
                    
                    if(segments(temp).inOut==segments(temp1).inOut)
                       segments(count).non_con=1;
                    else
                       segments(count).non_con=0;
                    end
                    count=count+1;
                    events=Func_SortEvents(events);
                     %��BD
                    
                    return;
                 end
                 
                 
             elseif  segments(sortline{2}).start_x ==segments(sortline{3}).end_x && segments(sortline{2}).start_y==segments(sortline{3}).end_y
                 %�����߶�һ���˵� 
                 return;
             else 
                 %�����غ�
%                  segments(sortline{1}).non_con=0;
                 if sortline{1}==sortline{3}
                     if(segments(temp).inOut==segments(temp1).inOut)
                         segments(sortline{2}).non_con=1;
                     else
                        segments(sortline{2}).non_con=0;
                     end
                     old_e=find(events(:,3)==sortline{1});
                     old_e1=find(events(:,3)==sortline{2});
                     events(old_e,3)=sortline{2};
                     events=[events; segments(sortline{2}).start_x, segments(sortline{2}).start_y,sortline{1},-2];
                     events(old_e1,3)=count;
                     events=[events; segments(sortline{3}).end_x,segments(sortline{3}).end_y,count,-1];
                     count=count+1;
                     events=Func_SortEvents(events);
%                       segments=[segments;Segment(segments(sortline{2}).start_x,segments(sortline{2}).start_y,segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{3}).poly,false,true,false)];
                      segments=[segments;Segment(segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{4}).end_x,segments(sortline{4}).end_y,segments(sortline{4}).poly,false,false,-1)];
                      segments(sortline{2}).end_x=segments(sortline{3}).end_x;
                      segments(sortline{2}).end_y=segments(sortline{3}).end_y;
                      segments(sortline{1}).end_x=segments(sortline{2}).start_x;
                      segments(sortline{1}).end_y=segments(sortline{2}).start_y;
                  
                  
                        
                        return;
                 else
                     %����
%                        segments=[segments;Segment(segments(sortline{2}).start_x,segments(sortline{2}).start_y,segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{3}).poly,false,true)];
                      
                      if(segments(temp).inOut==segments(temp1).inOut)
                         segments(sortline{2}).non_con=1;
                      else
                         segments(sortline{2}).non_con=0;
                      end
                      segments=[segments;Segment(segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{4}).end_x,segments(sortline{4}).end_y,segments(sortline{4}).poly,false,false,-1)];
                      segments(sortline{1}).end_x=segments(sortline{2}).start_x;
                      segments(sortline{1}).end_y=segments(sortline{2}).start_y;
%                       segments(sortline{2}).end_x=segments(sortline{3}).end_x;
%                       segments(sortline{2}).end_y=segments(sortline{3}).end_y;
                     %���غ�
                        old_e=find(events(:,3)==sortline{4});
%                         old_e1=find(events(:,3)==sortline{2});
                        events(old_e,3)=count;
                        events=[events; segments(sortline{2}).start_x, segments(sortline{2}).start_y,sortline{1},-2];
                        events=[events; segments(sortline{3}).end_x, segments(sortline{3}).end_y,count,-1];
                        count=count+1;
%                         events(old_e1,3)=count;
%                         events=[events; segments(sortline{3}).end_x,segments(sortline{3}).end_y,sortline{2},-2];
%                         events=[events; segments(sortline{3}).end_x,segments(sortline{3}).end_y,count,-1];
%                         count=count+1;
                        events=Func_SortEvents(events);
                        return;
                 end

             end
%            
         else
             %���ڶ˵���Բ���
             return;
         end
    else
        return;
    end
end

   
end
    



