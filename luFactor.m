function [L,U,P] = luFactor(A)
% Created on: March 30, 2019
% By: Hunter Flowers 

% luFactor - determines the LU factorization of a square matrix using
% partial pivoting
%    Inputs:
%        A - square matrix which will be factored
%    Outputs:
%        L - lower triangular matrix of factorization
%        U - upper triangular matrix of factorization
%        P - pivot matrix  

%Determine if the proper number of inputs were entered
if nargin ~= 1
    error('Exactly one input must be entered.')
end

%Determine the size of the inputted matrix
[rows, columns] = size(A);

%Ensure a square matrix was entered
if rows ~= columns
    error('A square matrix must be entered.')
end  

%Identify the initial pivot matrix as the identity matrix
P = eye(rows); 
L = eye(rows);
U = A;

%Loop through each row of the initial upper matrix pivoting the maximum
%absolute value
for i = 1:rows
  [maximum,j] = max(abs(U(i:rows,i)));     
%
  j = j + i - 1;
  if j ~= i
%Pivot rows m and i in matrix U (upper triangular)
    U([j,i],:) =  U([i,j],:); 
%Pivot rows m and i in matrix P (pivot matrix)
    P([j,i],:) =  P([i,j],:);  
%The first line of matrix L is always the same - pivoting must begin on
%row 2
    if i >= 2  
%Pivot rows m and i in columns 1:i-1 of matrix L (the last column of L is
%always 1)
      L([j,i],1:i-1) =  L([i,j],1:i-1);  
    end
  end
%Carry-out Gauss elimination to produce the necessary zeros in U
  for k = i + 1:rows  
%Determine Gauss elimination ratio
    L(k,i) = U(k,i) / U(i,i);
%Substitute values into U and L to arrive at final factorization
    U(k,:) =  U(k,:) - L(k,i)*U(i,:);
  end
end
