function [c] = linearInterpolationEnlarge(image,scale)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
a = image;
[p,q,r] = size(a);
k = scale;

%use k*(n-1)+1 formula for linear interpolation
m = k*(p-1)+1;
n = k*(q-1)+1;
b = zeros(m,n,r);

%fill the pixels from image at proper positions in new matrix
b(1:k:end, 1:k:end, :) = a(1:end, 1:end, :);

%interpolate across rows
for i=1:k:m
    for j=1:k:n-k
        mx = max(b(i,j,:),b(i,j+k,:));
        mn = min(b(i,j,:),b(i,j+k,:));
        diff = round((mx-mn)/k);
        if b(i,j,:) == mn
            l = 0;
            while(l<k-1)
                l = l+1;
                b(i,j+l,:) = mn + diff*l;
            end
        else
            l = 0;
            while(l<k-1)
                l = l+1;
                b(i,j+l,:) = mx - diff*l;
            end
        end
    end
end

%interpolate across columns
for i=1:k:m-k
    for j=1:n
        mx = max(b(i,j,:),b(i+k,j,:));
        mn = min(b(i,j,:),b(i+k,j,:));
        diff = round((mx-mn)/k);
        if b(i,j,:) == mn
            l = 0;
            while(l<k-1)
                l = l+1;
                b(i+l,j,:) = mn + diff*l;
            end
        else
            l = 0;
            while(l<k-1)
                l = l+1;
                b(i+l,j,:) = mx - diff*l;
            end
        end
    end
end

c = uint8(b);

end

