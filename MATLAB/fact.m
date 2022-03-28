close all; 
n = input("Enter minimum value "); 
k = input("Enter maximum value");
i = n:k;                        % creates a range 
pri = isprime(i);               % it's logical array which will tell if there is a prime number in the range 
out = i(pri);                   % saves all the prime numbers in the range in new array out 
result = nchoosek(out, 3);      % select 3 distinct primes from array 'out' 
disp(result);            
[rows,coln] = size(result);     % size of result 
disp(rows); 
for i = 1: rows
     m = factorial (result(i, 1));
     p = factorial (result(i,2));
     k = factorial (result(i,3));
     t = m*p* result(i,3);      % check the identity 
        if  t == k 
         disp("True");          % return true if any set satisfy the identity 
         else 
         disp("False");
       end
end