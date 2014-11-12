%This file Generate toy data according to Houlsby2014

%% Parameter Setting
n = 50;  % #Users
d = 200; % #Items

L = 5; % #Classes

h = 10;  % The rank of matrix

%%prior parameters
m_u = normrnd(0,1,[h,1]);
m_v = normrnd(0,1,[h,1]);

v_u = gamrnd(10/2, 2/10, [h,1]);
v_v = gamrnd(10/2, 2/10, [h,1]);

a0 = 10/2;
b0 = 10*sqrt(10) /2;

gam_row = gamrnd(a0, 1/b0, [n,1]);
gam_col = gamrnd(a0, 1/b0, [d,1]);

m_b0 = [-6; -2; 2; 6];
v0 = 0.1;

b0 = normrnd(m_b0, v0 * ones(size(m_b0)));

%% Parameters

% u
U = zeros(h, n);
for i = 1:n
    U(:,i) = normrnd(m_u, v_u);
end

% v
V = zeros(h, d);
for i = 1:d
    V(:,i) = normrnd(m_v, v_v);
end

% c
C = U' * V;

% a
A = normrnd(C, gam_row * gam_col');

% B
B = zeros(L-1, d);
for i = 1:d
    B(:,i) = normrnd(b0, v0);
end

%R
tmp = zeros(size(A));
for i = 1: L-1
    tmp = tmp + bsxfun(@ge, A, B(i,:));
end
R = tmp + 1;





