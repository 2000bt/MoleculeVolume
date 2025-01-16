%%找到种子Cube
function [Seedcube_num] = Func_Findseedcube( CubePoints, step_num1, step_num2, step_num3 )
Cub_num = step_num2 * step_num3;
a = step_num1 * step_num2 * step_num3;
Seedcube_num = 0;
    for i = 1 : step_num1
        if (i == step_num1)%边界位置不取，已经没有Cube
            continue;
        end
        for j = 1 :step_num2
            if(j == step_num2)
                continue;
            end
            for k = 1 : step_num3
                if( k == step_num3)
                    continue;
                end
                num_3 = k + step_num3 * (j - 1) + step_num2 * step_num3* (i -1);
                num_2 = num_3 + step_num3;
                num_7 = num_3 + Cub_num;
                num_6 = num_3 + Cub_num + step_num3; 
                num_0 = num_3 + 1;
                num_1 = num_3 + step_num3 + 1;
                num_4 = num_3 + Cub_num + 1;
                num_5 = num_3 + Cub_num + step_num3 + 1;
                count = CubePoints(num_0, 5) + CubePoints(num_1, 5) + CubePoints(num_2, 5) + CubePoints(num_3, 5) + CubePoints(num_4, 5) + CubePoints(num_5, 5) + CubePoints(num_6, 5) + CubePoints(num_7, 5);
                if (count ~= 8 && count ~= 0)
                    Seedcube_num = num_3;
                    return;
                end
            end
        end
    end
    