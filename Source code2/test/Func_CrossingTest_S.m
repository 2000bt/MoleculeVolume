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
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp).end_x,segments(temp).end_y,segments(temp).poly,false,true)];
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp1).end_x,segments(temp1).end_y,segments(temp1).poly,false,true)];
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
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp1).end_x,segments(temp1).end_y,segments(temp1).poly,false,true)];
        segments(temp1).end_x=intersection(1);
        segments(temp1).end_y=intersection(2);
        
        old_e1=find(events(:,3)==temp1);
        events(old_e1,3)=count;
        events=[events;intersection(1),intersection(2),temp1,-2];
        events=[events;intersection(1),intersection(2),count,-1];
        count=count+1;
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
        segments=[segments;Segment(intersection(1),intersection(2),segments(temp).end_x,segments(temp).end_y,segments(temp).poly,false,true)];
        segments(temp).end_x=intersection(1);
        segments(temp).end_y=intersection(2);
        
        old_e=find(events(:,3)==temp);
        events(old_e,3)=count;
        events=[events;intersection(1),intersection(2),temp,-2];
        events=[events;intersection(1),intersection(2),count,-1];
        count=count+1;
    elseif((Cross_P1*Cross_P2)==0&&(Cross_P3*Cross_P4)==0)
         if(Cross_P1==0)&&(Cross_P2==0)
             sortline={};
             result1=sort(line_1x(1),line_1y(1),line_2x(1),line_2y(1));
             result2=sort(line_1x(2),line_1y(2),line_2x(2),line_2y(2));
             switch result1
                 case 0
                     sortline{end+1}=0;
                 case 1
                     sortline{end+1}=temp;
                     sortline{end+1}=temp1;
                 case 2
                     sortline{end+1}=temp1;
                     sortline{end+1}=temp;
                 
             end
             switch result2
                 case 0  
                     sortline{end+1}=0;
                 case 1
                     sortline{end+1}=temp;
                     sortline{end+1}=temp1;
                 case 2
                     sortline{end+1}=temp1;
                     sortline{end+1}=temp; 
             end
             if size(sortline,1)==2 %�غ�
                 Flag=4;
                 P(1,1)=Line_1x(1);
                 P(1,2)=Line_1y(1);
                 P(2,1)=Line_1x(2);
                 P(2,2)=Line_1y(2); 
             elseif size(sortline,1)==3 %��һ���˵�
                 if sortline{1}==0
                     %��AC
                     segments=[segments;Segment(segments(sortline{2}).end_x,segments(sortline{2}).end_y,segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{3}).poly,false,true)];
                     segments(sortline{3}).end_x=segments(sortline{2}).end_x;
                     segments(sortline{3}).end_y=segments(sortline{2}).end_y;
                     
                     %�ı�events
                    old_e=find(events(:,3)==sortline{3});
                    events(old_e,3)=count;
                    events=[events;segments(sortline{2}).end_x,segments(sortline{2}).end_y,sortline{3},-2];   
                    events=[events;segments(sortline{2}).end_x,segments(sortline{2}).end_y,count,-1];
                    count=count+1;
                    events=Func_SortEvents(events);
                 else
                     %��BD,��������ϸ��
                     
                     segments=[segments;Segment(segments(sortline{2}).start_x,segments(sortline{2}).start_y,segments(sortline{2}).end_x,segments(sortline{2}).end_y,segments(sortline{1}).poly,false,true)];
                     segments(sortline{1}).end_x=segments(sortline{2}).start_x;
                     segments(sortline{1}).end_y=segments(sortline{2}).start_y;
                     
                     %�ı�events
                    old_e=find(events(:,3)==sortline{1});
                    events(old_e,3)=count;
                    events=[events;segments(sortline{2}).start_x,segments(sortline{2}).start_y,sortline{1},-2];   
                    events=[events;segments(sortline{2}).start_x,segments(sortline{2}).start_y,count,-1];
                    count=count+1;
                    events=Func_SortEvents(events);
                     %��BD
                 end
                 
             elseif  sort(segments(sortline{2}).start_x,segments(sortline{2}).start_y,segments(sortline{3}).end_x,segments(sortline{3}).end_y)==0
                 %�����߶�һ���˵� 
                 return;
             else 
                 %�����غ�
                 if sortline{1}==sortline{3}
                     %���غ�
                    old_e=find(events(:,3)==sortline{1});
                    old_e1=find(events(:,3)==sortline{2});
                    events(old_e,3)=count;
                    events=[events; segments(sortline{2}).start_x, segments(sortline{2}).start_y,sortline{1},-2];
                    events=[events; segments(sortline{2}).start_x, segments(sortline{2}).start_y,count,-1];
                    count=count+1;
                    events(old_e1,3)=count;
                    events=[events; segments(sortline{3}).end_x,segments(sortline{3}).end_y,sortline{2},-2];
                    events=[events; segments(sortline{3}).end_x,segments(sortline{3}).end_y,count,-1];
                    count=count+1;
                    events=Func_SortEvents(events);
                        
                   segments=[segments;Segment(segments(sortline{2}).start_x,segments(sortline{2}).start_y,segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{3}).poly,false,true)];
                   segments=[segments;Segment(segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{4}).end_x,segments(sortline{4}).end_y,segments(sortline{4}).poly,false,true)];
                   segments(sortline{1}).end_x=segments(sortline{2}).start_x;
                   segments(sortline{1}).end_y=segments(sortline{2}).start_y;
                   segments(sortline{2}).end_x=segments(sortline{3}).end_x;
                   segments(sortline{2}).end_y=segments(sortline{3}).end_y;
                     
                 else
                     %���غ�
                        old_e=find(events(:,3)==sortline{4});
%                         old_e1=find(events(:,3)==sortline{2});
                        events(old_e,3)=count;
                        events=[events; segments(sortline{2}).start_x, segments(sortline{2}).start_y,sortline{1},-2];
                        events=[events; segments(sortline{3}).end_x, segments(sortline{2}).end_y,count,-1];
                        count=count+1;
%                         events(old_e1,3)=count;
%                         events=[events; segments(sortline{3}).end_x,segments(sortline{3}).end_y,sortline{2},-2];
%                         events=[events; segments(sortline{3}).end_x,segments(sortline{3}).end_y,count,-1];
%                         count=count+1;
                        events=Func_SortEvents(events);
                        
%                      segments=[segments;Segment(segments(sortline{2}).start_x,segments(sortline{2}).start_y,segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{3}).poly,false,true)];
                      segments=[segments;Segment(segments(sortline{3}).end_x,segments(sortline{3}).end_y,segments(sortline{4}).end_x,segments(sortline{4}).end_y,segments(sortline{4}).poly,false,true)];
                      segments(sortline{1}).end_x=segments(sortline{2}).start_x;
                      segments(sortline{1}).end_y=segments(sortline{2}).start_y;
%                       segments(sortline{2}).end_x=segments(sortline{3}).end_x;
%                       segments(sortline{2}).end_y=segments(sortline{3}).end_y;
                     
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

    function result=sort(line_1x,line_1y,line_2x,line_2y)
        if line_1x>line_2x
            result = 1;
        elseif line_2x>line_1x
            result= 2;
        elseif ~isequal([line_1x,line_1y],[line_2x,line_2y])
           if line_1y>line_2y
              result = 1;
           else
              result = 2;
           end
        else
            result= 0;
        end
            
    end

        
end
    



