function result = find_changes(path, min_distance)
    matrix = csvread(path);
    path = path(1:(length(path)-4));
    
    n = size(matrix,2);
    result = zeros(1,n);
    
    for i = 2:n
        last = matrix(2:3,i-1);
        current = matrix(2:3,i);
        distance = mandist(last',current);
        if distance >= min_distance
            result(i) = 1;
        end
    end
    
    csvwrite(strcat(path,'_changes.csv'),result);
end