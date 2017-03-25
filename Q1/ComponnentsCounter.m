function [] = ComponnentsCounter(image)
   
    newSizeImage = imresize(image, [500 500]);
    newSizeImage = im2bw(newSizeImage,0.7);
   % figure('Name','newSizeImage','NumberTitle','off'),imshow(newSizeImage);
    visited = false(size(newSizeImage));
    [rows,cols] = size(newSizeImage);
    B = zeros(rows,cols);
    componment_marker = 1;

    %// goes over every coordinate in the matrix
    for row = 1 : rows
        for col = 1 : cols
            % checks if the point had been visited or not, if not mark it
            % as visited                   
            if newSizeImage(row,col) == 0
                visited(row,col) = true;

            %// In case point had been visited
            elseif visited(row,col)
                continue;
            
            else
                %// Initialize the stack with this point
                stack = [row col];

                %// checks if stack isn't empty
                while ~isempty(stack)
                    %// Pop the point from the  stack
                    point = stack(1,:);
                    stack(1,:) = [];

                    %// If point had been visited, continue to this line
                    if visited(point(1),point(2))
                        continue;
                    end
               
                    %puts 1 on visited points and puts the componment_marker
                    %as componment mark
                    visited(point(1),point(2)) = true;
                    B(point(1),point(2)) = componment_marker;

                    %// searches the 8 neighbouring points
                    [points_y, points_x] = meshgrid(point(2)-1:point(2)+1, point(1)-1:point(1)+1);
                    points_y = points_y(:);
                    points_x = points_x(:);

                    %// checks if points are out the bounds
                    out_of_bounds = points_x < 1 | points_x > rows | points_y < 1 | points_y > cols;

                    points_y(out_of_bounds) = [];
                    points_x(out_of_bounds) = [];

                    %// strikes out the points that are already marked 1
                    is_visited = visited(sub2ind([rows cols], points_x, points_y));

                    points_y(is_visited) = [];
                    points_x(is_visited) = [];

                    %//  strikes out the points that are marked 0
                    is_1 = newSizeImage(sub2ind([rows cols], points_x, points_y));
                    points_y(~is_1) = [];
                    points_x(~is_1) = [];

                    %// Add the rest of the points to the stack
                    stack = [stack; [points_x points_y]];
                end

                %// Increment the componment_marker by 1
                componment_marker = componment_marker + 1;
            end
        end
    end
    disp(B);
   % figure('Name','B','NumberTitle','off'),imshow(B);
    disp(componment_marker);
end