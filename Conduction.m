m = 100; % number of elements in y direction
n = 100; % number of elements in x direction
A = zeros(m*n); % initialize coefficient matrix
b = zeros(m*n,1); % so called load vector
%% innerNodes coefficients
for i = 1:1:m
    for j = 1:1:n
        countT = i + (j-1)*m;
        if i > 1 && i < m && j > 1 && j < n
            A(countT,countT) = -4;
            A(countT,countT+1) = 1; % south temperature coefficient
            A(countT, countT-1) = 1; % north temperature coefficient
            A(countT, countT + m) = 1; % east temperature coefficient
            A(countT, countT - m) = 1; % west temperature coefficient
        end
    end
end

%% boundary conditions - can be included in the above nested for as well

for i = 1:1:m
    for j = 1:1:n
        countT = i + (j-1)*m;
        if j == 1 % left side
            A(countT,countT) = 1;
            b(countT) = 0;
        else if j == n % right side
                A(countT,countT) = 1;
                b(countT) = 0;
            else if i == 1 % top side
                    A(countT,countT) = 1;
                    b(countT) = 1;
                else if i == m % bottom side
                        A(countT,countT) = 1;
                        b(countT) = 0;
                    end
                end
            end
        end
    end
end

tic
display('Starting Gauss elimination')
T = A\b;
display('Ending Gauss elimination')
toc
T1 = reshape(T,[m n]);
x = linspace(0,1,n);
y = linspace(0,1,m);
[X,Y] = meshgrid(x,y);
contour(X,Y,T1,10,'k-','showtext','on')
axis equal
%contourf(X,Y,T1)
%axis equal
