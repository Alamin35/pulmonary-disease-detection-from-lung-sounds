function [maxNumber, occurrences] = maxoccurrences(matrix)
a = matrix;
b = mode(a);
x = 0;
for i = 1:length(a)
    if a(i)==b
        x = x+1;
    end
end
maxNumber = b;
occurrences =x;
end
