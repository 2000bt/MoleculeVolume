
function [point,num_con]=Func_FindOverlap_4(mLine,mLine1,vXtemp,vYtemp,vXtemp1,vYtemp1,aaa)
% mLine=[2,3;3,1;1,4;4,2];
% vXtemp=[2;0;2;0];
% vYtemp=[2;0;0;2];
% mLine1=[1,4;4,3;3,2;2,1];
% vXtemp1=[1;3;3;1];
% vYtemp1=[1;1;3;3];
% mLine=[2,3;3,1;1,4;4,2];
% vXtemp=[2;0;2;0];
% vYtemp=[3;0;0;3];
% mLine1=[1,2;2,3;3,4;4,5;5,6;6,7;7,8;8,1];
% vXtemp1=[1;3;3;1;1;2;2;1];
% vYtemp1=[0;0;4;4;2;2;1;1];
point={};
num_con=0;
%%
%线段赋值给Segment
len=length(mLine);
if len<3
    return;
end
% mLine(len,2)=mLine(1,1);
len1=length(mLine1);
if len1<3
    return;
end
% mLine1(len1,2)=mLine1(1,1);
%先把多边形中的线排列好再赋值
Len_ALL=len+len1;

segments = repmat(Segment(0, 0, 0, 0, 0,false,true,-1),Len_ALL, 1 ); % 预分配数组

count=1;
idx_other=[];
% idx_other1=[];
% idx_other2=[];
for i=1:len
     L1x(1)=vXtemp(mLine(i,1));
     L1x(2)=vXtemp(mLine(i,2));
     L1y(1)=vYtemp(mLine(i,1));
     L1y(2)=vYtemp(mLine(i,2));
     if(isequal([L1x(1),L1y(1)],[L1x(2),L1y(2)]))
         continue;
     end
     if(L1x(2)<L1x(1))
         segments(count)=Segment(L1x(2),L1y(2),L1x(1),L1y(1),1,false,true,-1);
         count=count+1;
     elseif((L1x(2)==L1x(1))&&(L1y(2)<L1y(1)))
         segments(count)=Segment(L1x(2),L1y(2),L1x(1),L1y(1),1,false,true,-1);
         count=count+1;
     else
         segments(count)=Segment(L1x(1),L1y(1),L1x(2),L1y(2),1,false,true,-1);
         count=count+1;
     end
end
for j=1:len1
     L2x(1)=vXtemp1(mLine1(j,1));
     L2x(2)=vXtemp1(mLine1(j,2));
     L2y(1)=vYtemp1(mLine1(j,1));
     L2y(2)=vYtemp1(mLine1(j,2));
     %清除一个端点的边
     if(isequal([L2x(1),L2y(1)],[L2x(2),L2y(2)]))
         continue;
     end
     if(L2x(2)<L2x(1))
         segments(count)=Segment(L2x(2),L2y(2),L2x(1),L2y(1),2,false,true,-1);
         count=count+1;
     elseif((L2x(2)==L2x(1))&&(L2y(2)<L2y(1)))
         segments(count)=Segment(L2x(2),L2y(2),L2x(1),L2y(1),2,false,true,-1);
         count=count+1;
     else
         segments(count)=Segment(L2x(1),L2y(1),L2x(2),L2y(2),2,false,true,-1);
         count=count+1;
     end
end
segments(count:Len_ALL,:)=[];
% 初始化事件队列（Event Queue）和状态树（Sweep Line Status）
%%
%每个点放进事件队列
events =zeros((count-1)*2,4);
% events=[];
% 使用循环创建事件并按行添加到数组中
for i = 1:count-1
% for i=1:1
    start_x = segments(i).start_x;
    start_y = segments(i).start_y;
    end_x = segments(i).end_x;
    end_y = segments(i).end_y;
    
   % 添加进入点事件
    events(2*i-1,:) = [start_x, start_y, i, -1];
%     events(end+1, :) = [start_x, start_y, i, 1];
    % 添加离开点事件
    events(2*i, :) = [end_x, end_y, i, -2];
%      events(end+1, :) = [end_x, end_y, i, -1];
end

% % 按X坐标排序事件队列：x-y-右左-线段上下
events=Func_SortEvents(events);
%%
%开始扫描
%初始化扫描线位置
current_x = -inf;
status=[];
% 初始化结果存储
% intersections = [10000,10000,10000,10000];
% intersections=[];
% num_inter=1;%用于记录交点的数目，细分线段时处理

while ~isempty(events)
    event = events(1, :);
    events(1, :) = [];

    % 更新扫描线位置
    current_x = event(1);
%     if aaa==3
%     
%     end
    if(current_x>=-3.33)
        a=1;
%         y = linspace(-14, 7); % 设置 y 坐标的范围
%     plot([current_x, current_x], [min(y), max(y)],'r');
    end
    if event(4) == -1 % 左端点事件
        % 添加线段到状态,此处应当按照与扫描线交点的y轴大小排序
        status = [status; struct('x',event(1),'y', event(2), 'segment', event(3),'inte_y',event(2) )];
% 
% 更新状态结构体
        if numel(status) == 1
            %只要队列中只存在一个端点，就保留原属性，因为肯定属于外轮廓
            continue;
        end
        %%%排序
        for ss=1:numel(status)
            %计算和扫描线交点再排序
            line=status(ss).segment;
            if(segments(line).end_x==segments(line).start_x)
                status(ss).inte_y=segments(line).start_y;
                continue;
            end
            slope =(segments(line).end_y-segments(line).start_y)/(segments(line).end_x-segments(line).start_x);
            status(ss).inte_y= segments(line).start_y + slope * (current_x - segments(line).start_x);
        end
        
        [~, idx] = sort([status.inte_y]);
        status = status(idx);%排序状态队列
        idx_new=find(idx==max(idx));
%         while idx_new > 0 
            % 检查与前一个线段的交点
            if numel(status) == 2
                temp=status(1).segment;
                temp1=status(2).segment;
                if(idx_new~=1)
                    %处理标志位
                  [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp);
                  [segments,events,count,Flag]=Func_CrossingTest_S1(temp,temp1,segments,events,count);
                  if(Flag==1)
                      segments(temp).inOut=false;
                      segments(temp).otherInOut=true;
                      [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp);
                      [segments(temp).non_con,segments(temp1).non_con]=Func_GetCon(segments,temp,temp1);
%                   elseif(Flag==2)
%                       status([1;2],:)=status([2;1],:);
%                       segments(temp1).inOut=false;
%                       segments(temp1).otherInOut=true;
%                       [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp1);
                  end
                else
                    [segments,events,count,Flag]=Func_CrossingTest_S1(temp,temp1,segments,events,count);
                   if(Flag==1)
                      [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp);
                      [segments(temp).non_con,segments(temp1).non_con]=Func_GetCon(segments,temp,temp1); 
%                    elseif(Flag==2)
%                       status([1;2],:)=status([2;1],:);
%                       segments(temp1).inOut=false;
%                       segments(temp1).otherInOut=true;
%                       [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp1);
%     %                  
%                    end
                end   
                break;
            end
            
            if numel(status) > 2    
                if(idx_new==1)
                    temp=status(1).segment;
                    temp1=status(2).segment;
                    [segments,events,count,Flag]=Func_CrossingTest_S1(temp,temp1,segments,events,count);
                    if(Flag==1)
                      [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp); 
                      [segments(temp).non_con,segments(temp1).non_con]=Func_GetCon(segments,temp,temp1);
%                     elseif(Flag==2)
%                       status([1;2],:)=status([2;1],:);
%                       segments(temp1).inOut=false;
%                       segments(temp1).otherInOut=true;
%                       [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp1);
%                       idx_new=2;
%                       Flag = 4;
%                       continue;
%                        temp2=status(3).segment;
%                        [segments,events,count,Flag]=Func_CrossingTest_S1(temp,temp2,segments,events,count);
                    end
                elseif(idx_new==numel(status))
                    %处理标志位
                    temp=status(idx_new-1).segment;
                    temp1=status(idx_new).segment;   
                    [segments,events,count,Flag]=Func_CrossingTest_S1(temp,temp1,segments,events,count); 
                    [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp);    
                    if(Flag==1)
                      temp2=status(idx_new-2).segment;    
                      [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp2);    
                      [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp);
                      [segments(temp).non_con,segments(temp1).non_con]=Func_GetCon(segments,temp,temp1);
%                     elseif(Flag==2)
%                        temp2=status(idx_new-2).segment;
%                        status([idx_new-1;idx_new],:)=status([idx_new;idx_new-1],:);
%                        [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp2);
%                        [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp1);
%                        idx_new=idx_new-1;
%                        Flag=3;
%                        continue;
                    end
                else
                    %处理标志位
                    temp=status(idx_new).segment;
                    temp1=status(idx_new-1).segment;
                    temp2=status(idx_new+1).segment;
%                     if Flag==3  %和前相交检测
% %                                 [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp1);    
%                                 [segments,events,count,Flag]=Func_CrossingTest_S1(temp1,temp,segments,events,count);
%                                  if(Flag==1)
%                                %前
%                                if idx_new~=2
%                                    temp3=status(idx_new-2).segment;
%                                    [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp3);    
%                                    [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp1);  
%                                    [segments(temp1).non_con,segments(temp).non_con]=Func_GetCon(segments,temp1,temp);
%                                else
%                                    segments(temp1).inOut=false;
%                                    segments(temp1).otherInOut=true;
%                                    [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp1);
%                                    [segments(temp1).non_con,segments(temp).non_con]=Func_GetCon(segments,temp1,temp);
%                                end
%                            elseif Flag==2
%                                status([idx_new-1;idx_new],:)=status([idx_new;idx_new-1],:);
%                                if idx_new-2>0
%                                    temp3=status(idx_new-2).segment;
%                                    [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp3);
%                                    [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp); 
%                                    idx_new=idx_new-1;
%                                else
%                                    segments(temp).inOut=false;
%                                    segments(temp).otherInOut=true;
%                                    [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp); 
%                                    break;
%                                end
%                                Flag=3;
%                                continue;
%                            end
% 
%                   elseif Flag==4 %后
%                         [segments,events,count,Flag]=Func_CrossingTest_S1(temp,temp2,segments,events,count);
%                         if(Flag==1)
%                            %后
%                            [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp1);  
%                            [segments(temp2).inOut,segments(temp2).otherInOut]=Func_GetFlag(segments,temp2,temp);  
%                            [segments(temp).non_con,segments(temp2).non_con]=Func_GetCon(segments,temp,temp2);
%                        elseif Flag==2
%                            status([idx_new;idx_new+1],:)=status([idx_new+1;idx_new],:);
%                            [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp2);   
%                            idx_new=idx_new+1;
%                            if idx_new==numel(status)
%                                break;
%                            end
%                            Flag=4;
%                            continue;
%                        end
%                    else
                       [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp1);    
                       [segments,events,count,Flag]=Func_CrossingTest_S1(temp1,temp,segments,events,count);

                       if(Flag==1)
                           %前
                           if idx_new~=2
                               temp3=status(idx_new-2).segment;
                               [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp3);    
                               [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp1);  
                               [segments(temp1).non_con,segments(temp).non_con]=Func_GetCon(segments,temp1,temp);
%                            else
%                                segments(temp1).inOut=false;
%                                segments(temp1).otherInOut=true;
%                                [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp1);
%                                [segments(temp1).non_con,segments(temp).non_con]=Func_GetCon(segments,temp1,temp);
                           end
                       elseif Flag==2
                           status([idx_new-1;idx_new],:)=status([idx_new;idx_new-1],:);
                           if idx_new-2>0
                               temp3=status(idx_new-2).segment;
                               [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp3);
                               [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp); 
                               idx_new=idx_new-1;
%                            else
%                                segments(temp).inOut=false;
%                                segments(temp).otherInOut=true;
%                                [segments(temp1).inOut,segments(temp1).otherInOut]=Func_GetFlag(segments,temp1,temp); 
%                                break;
%                            end
%                            Flag=3;
%                            continue;
                       end

                       [segments,events,count,Flag]=Func_CrossingTest_S1(temp,temp2,segments,events,count);
                       if(Flag==1)
                           %后
                           [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp1);  
                           [segments(temp2).inOut,segments(temp2).otherInOut]=Func_GetFlag(segments,temp2,temp);  
                           [segments(temp).non_con,segments(temp2).non_con]=Func_GetCon(segments,temp,temp2);
%                        elseif Flag==2
%                            status([idx_new;idx_new+1],:)=status([idx_new+1;idx_new],:);
%                            [segments(temp2).inOut,segments(temp2).otherInOut]=Func_GetFlag(segments,temp2,temp1);  
%                            [segments(temp).inOut,segments(temp).otherInOut]=Func_GetFlag(segments,temp,temp2);  
%                            
%                            idx_new=idx_new+1;
%                            if idx_new==numel(status)
%                                break;
%                            end
%                            Flag=4;
%                            continue;
                       end
                  end

                end
%                 break;
            end
        end
    else
        if (segments(event(3)).otherInOut==0 && segments(event(3)).non_con<0) || (segments(event(3)).non_con>0)
           idx_other(end+1)=event(3); 
        end
        for i = 1:numel(status)
       
            if isequal(status(i).segment, event(3))
                
                if(i==1||i==numel(status))
                    status(i) = [];
                    break;
                else
                    temp=status(i-1).segment;
                    temp1=status(i+1).segment;
                    [segments,events,count,Flag]=Func_CrossingTest_S1(temp,temp1,segments,events,count);
                    status(i) = [];
                    break;
                end
                
            end
        end 

          
    end
end

%%

 figure;
 hold on;
if ~isempty(idx_other)
    point1=[];
    len=length(idx_other);
    len2=len*2;
    results =zeros(len2,7);
    for i=1:len
% %         if segments(idx_other(i)).non_con~=0
            x=[segments(idx_other(i)).start_x,segments(idx_other(i)).end_x];
            y=[segments(idx_other(i)).start_y,segments(idx_other(i)).end_y]; 
            plot(x,y,'b');
%             point(end+1,:)=[x(1),y(1)];
%             point(end+1,:)=[x(2),y(2)];
            start_x = segments(idx_other(i)).start_x;
            start_y = segments(idx_other(i)).start_y;
            end_x = segments(idx_other(i)).end_x;
            end_y = segments(idx_other(i)).end_y;

           % 添加进入点事件
            results(2*i-1,1:6) = [start_x, start_y, i, -1,end_x,end_y];
        %     events(end+1, :) = [start_x, start_y, i, 1];
            % 添加离开点事件
            results(2*i,1:6) = [end_x, end_y, i, -2,start_x,start_y];
% %         end
    end
    results=Func_SortEvents(results);
    %设置pos
    for j=1:len2
        results(j,7)=j;
        if results(j,4)==-2
            idx=find(results(:,3)==results(j,3));
            idx=idx(idx~=j);
            temppos=results(idx,7);
            results(j,7)=temppos;
            results(idx,7)=j;
        end
    end
    %是否处理矩阵
    process = false(size(results, 1), 1); 
%     num_con=0;
%     num_point=0;

flag=0;
    for j=1:len2
        if process(j)
            continue;
        end
        pos=j;
        initial=results(j,1:2);
        num_con=num_con+1;
        point1=[];
        point1(end+1,:)=initial(:);
        scatter(initial(1,1),initial(1,2));
%         while(results(pos,5)==initial(1,1) && results(pos,5)==initial(1,2))
        while(~isequal(results(pos,5:6),initial))

            process(pos)=true;
            pos=results(pos,7);
            process(pos)=true;
            point1(end+1,:)=results(pos,1:2);
            scatter(results(pos,1),results(pos,2));
            pos=nextpos(pos,results,process);
            if pos <1 
                flag=1;
                break;
%                 return;
            end
        end
        if flag
            figure;
            hold on;
            for p=1:size(point1,1)
              scatter(point1(p,1),point1(p,2));  
            end
            hold off;
            title('wrong')
            num_con=num_con-1;
            disp('出错');
            return;
        end
        process(pos)=true;
        process(results(pos,7))=true;
        point{num_con,1}=point1;
    end
end

 function newpos = nextpos(pos,results,process)
        newpos=pos+1;
%         while newpos<length(results) && results(newpos,1)==results(pos,1) && results(newpos,2)==results(pos,2)
        while newpos<=size(results,1) && isequal(results(newpos,1:2),results(pos,1:2))
            if(~process(newpos))
                 return
            else
            newpos=newpos+1;
            end
        end
        %往前搜索
        newpos=pos-1;
        while(newpos>0 && process(newpos))
%         while(process(newpos))
            newpos=newpos-1;
%             return;
        end
        if newpos==0
            return;
        end
        
    end   
end

