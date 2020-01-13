close all; clear all;
load('hw1_images.mat');
x = noisyImg;
z = noisyImg;
[m, n] = size(z);
Egiven = 0;
values = [-1, 1];
h = 1;
b = 3;
v = 2;
Echanged = 100^(100);
num = 0;
change=0;
k=0;
p=0;
while abs(Egiven - Echanged) > 0
    Egiven = Echanged;
    Echanged = 0;
    num = num + 1;
    for i = 1:m
        for j = 1:n
            E_sum = zeros(1, length(values));
            for k = 1:length(values)
                Etemp = 0;
                n_up = i-1;
                if n_up >= 1
                    Etemp = Etemp + values(k)*z(n_up,j);
                end
                n_down = i+1;
                if n_down <= m
                    Etemp = Etemp + values(k)*z(n_down,j);
                end
                n_left = j-1;
                if n_left >= 1
                    Etemp = Etemp + values(k)*z(i,n_left);
                end
                n_right = j+1;
                if n_right <= n
                    Etemp = Etemp + values(k)*z(i,n_right);
                end
                Etemp = h*values(k)-b*Etemp-v*values(k)*x(i,j);
                E_sum(k) = Etemp;
            end
            [k, p] = min(E_sum);
            z(i, j) = values(p);
            Echanged = Echanged + k;
        end
    end
end
figure;
imagesc(z);
change = eq(origImg,z);
error_rate = sum(sum(change<1))/(m*n)
