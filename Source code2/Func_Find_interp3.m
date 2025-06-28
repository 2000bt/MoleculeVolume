%%方法一：连成完整轮廓后，用直线相交算交点
function[dS]= Func_Find_interp3(vXTemp,vYTemp,vXTemp1,vYTemp1,j,dSlice,step1)
Flag=1;
FontSize = 22;
FontWeight = 'bold';
mLine=[];
mLine1=[];
% point=[];
dS=0;
dS1=0;
%包围盒求交
Max_X=max(vXTemp);
Max_Y=max(vYTemp);
Max_X1=max(vXTemp1);
Max_Y1=max(vYTemp1);
Min_X=min(vXTemp);
Min_Y=min(vYTemp);
Min_X1=min(vXTemp1);
Min_Y1=min(vYTemp1);
w=Max_X-Min_X;
h=Max_Y-Min_Y;
w1=Max_X1-Min_X1;
h1=Max_Y1-Min_Y1;

%二维包围盒
if(((Min_X>Max_X1)||(Min_Y>Max_Y1))||((Max_X<Min_X1)||(Max_Y<Min_Y1)))
    Flag=0;
    return
end

%连接轮廓
if(Flag==1)
%       figure;
% %     hold on;
%    [mLineSub,LineFlag,vRectangle,iCountContour] = Func_Unicursal_5(vXTemp, vYTemp, dSlice); 
%    [mLineSub2,LineFlag2,vRectangle2,iCountContour2] = Func_Unicursal_5(vXTemp1, vYTemp1, step1(1)); 
   [mLineSub,LineFlag,vRectangle,iCountContour] = Func_Unicursal_TwoSearch(vXTemp, vYTemp, dSlice); 
   [mLineSub1,LineFlag1,vRectangle1,iCountContour1] = Func_Unicursal_TwoSearch(vXTemp1, vYTemp1, step1(1));
%    [mLineSub1,LineFlag1,vRectangle1] = Func_Unicursal_TwoSearch(vXTemp, vYTemp, dSlice)

%  hold off;  

    if iCountContour>1&&iCountContour1==1  
        for num_c=1:iCountContour
                if((vRectangle(num_c,1)>Max_X1)||(vRectangle(num_c,3)>Max_Y1)||(vRectangle(num_c,2)<Min_X1)||(vRectangle(num_c,4)<Min_Y1))
                        continue;
                else

                   [point,num_con]=Func_FindOverlap_1(mLineSub{num_c},mLineSub1{1},vXTemp,vYTemp,vXTemp1,vYTemp1,num_c);
                   if ~isempty(point)

                        dS1=Func_ComputeArea(point,num_con,LineFlag(num_c),LineFlag1);
                   else
                       dS1=0;
                   end
                end
                dS=dS+dS1;
        end

    elseif iCountContour1>1&&iCountContour==1 
       for num_c=1:iCountContour1
               if((vRectangle1(num_c,1)>Max_X)||(vRectangle1(num_c,3)>Max_Y)||(vRectangle1(num_c,2)<Min_X)||(vRectangle1(num_c,4)<Min_Y))
                        continue;
               else
                   [point,num_con]=Func_FindOverlap_1(mLineSub{1},mLineSub1{num_c},vXTemp,vYTemp,vXTemp1,vYTemp1);
                   if ~isempty(point)

                        dS1=Func_ComputeArea(point,num_con,LineFlag,LineFlag1(num_c));

                   else
                       dS1=0;
                   end
               end
               dS=dS+dS1;
        end
   elseif iCountContour1>1&&iCountContour>1 
       for num_c=1:iCountContour

           for num_c1=1:iCountContour1

               if((vRectangle(num_c,1)>vRectangle1(num_c1,2))||(vRectangle(num_c,3)>vRectangle1(num_c1,4))||(vRectangle(num_c,2)<vRectangle1(num_c1,1))||(vRectangle(num_c,4)<vRectangle1(num_c1,3)))
                        continue;
               else
                   [point,num_con]=Func_FindOverlap_1(mLineSub{num_c},mLineSub1{num_c1},vXTemp,vYTemp,vXTemp1,vYTemp1);
                    
                   if ~isempty(point)

                        dS1=Func_ComputeArea(point,num_con,LineFlag(num_c),LineFlag1(num_c1));
%                      
                   else
                       dS1=0;
                   end
                   
               end
               dS=dS+dS1;
           end
       end
       
    else
       [point,num_con]=Func_FindOverlap_1(mLineSub{1},mLineSub1{1},vXTemp,vYTemp,vXTemp1,vYTemp1);
       if ~isempty(point)
            dS=Func_ComputeArea(point,num_con,LineFlag,LineFlag1);

       end
   end

end
