function [A_estimate, E_estimate] = baumwelch(data, A_guess, E_guess, N_iter)
%
% Train Hidden Markov Model using the Baum-Welch algorithm (expectation maximization)
% Input:
%  data: N*T matrix, N data samples of length T
%  A_guess: K*K matrix, where K is the number hidden states [initial guess for the transition matrix]
%  E_guess: K*E matrix, where E is the number of emissions [initial guess for the emission matrix]
%
% Output:
%  A_estimate: estimate for the transition matrix after N_iter iterations of expectation-maximization 
%  E_estimate: estimate for the emission matrix after N_iter iterations of expectation-maximization
%
% CSCI 576 2014 Fall, Homework 5
% digits(40);
A_guess(1,1) = A_guess(1,1) - 0.1;
A_guess(1,2) = A_guess(1,2) + 0.1;
[N,T] = size(data);
[K,K] = size(A_guess);
[K,EE] = size(E_guess);
A_estimate = zeros(K,K);
E_estimate = zeros(K,EE);
alpha = zeros(T,K);
beta = zeros(T,K);
pi = [0.5,0.5];
superP = zeros(T-1,K,K);
unsuperP = zeros(T,K);

for it = 1:N_iter
    disp(it)
    sumA1 = zeros(K,K);
    sumA2 = zeros(K,K);
    sumE3 = zeros(K,EE);
    sumE4 = zeros(K,EE);
    for n = 1:N
        Y = data(n,:);
        %initial alpha
        for i = 1:K
            alpha(1,i) = pi(i) * E_guess(i,Y(1));
        end
        for t = 1:T-1
            for j = 1:K
                sum1 = 0;
                for i = 1:K
                    sum1 = sum1 + alpha(t,i) * A_guess(i,j);
                end
                alpha(t+1,j) = sum1 * E_guess(j,Y(t+1));
            end
        end

        %initial beta
        for i = 1:K
            beta(T,i) = 1;
        end
        for t = T-1:-1:1
            for i = 1:K
                sum1 = 0;
                for j = 1:K
                    sum1 = sum1 + A_guess(i,j) * E_guess(j,Y(t+1)) * beta(t+1,j);
                end
                beta(t,i) = sum1;
            end
        end

        %initial P(Y(1:T))
        PY1T = 0;
        for i = 1:K
            PY1T = PY1T + alpha(T,i);
        end
        
        %[alpha,beta,PY1T] = initial(Y,pi,A_guess,E_guess,alpha,beta);
           
        for t = 1:T-1
            for i = 1:K
                for j = 1:K
                    sum1 = 0;
                    for ii = 1:K
                        for jj = 1:K
                            sum1 = sum1 + alpha(t,ii) * A_guess(ii,jj) * E_guess(jj,Y(t+1)) * beta(t+1,jj);
                        end
                    end
                    superP(t,i,j) = alpha(t,i) * A_guess(i,j) * E_guess(j,Y(t+1)) * beta(t+1,j) / sum1;
                end
            end
        end

        %initial unsuperP
        for t = 1:T
            for i = 1:K
                sum1 = 0;
                for ii = 1:K
                    sum1 = sum1 + alpha(t,ii) * beta(t,ii);
                end
                unsuperP(t,i) = alpha(t,i) * beta(t,i) / double(sum1);
            end
        end

        %estimate pi
        for i = 1:K
            pi(i) = unsuperP(1,i);
        end

        %estimate A_estimate
        for i = 1:K
            for j = 1:K
                for t = 1:T-1
                    sumA1(i,j) = sumA1(i,j) + superP(t,i,j);
                    sumA2(i,j) = sumA2(i,j) + unsuperP(t,i);
                end
            end
        end

        %estimate E_estimate
        for j = 1:K
            for k = 1:4
                for t = 1:T
                    if Y(t) == k
                        sumE3(j,k) = sumE3(j,k) + unsuperP(t,j);
                    end
                    sumE4(j,k) = sumE4(j,k) + unsuperP(t,j);
                end
            end
        end

    end
    A_estimate = sumA1 ./ sumA2;
    E_estimate = sumE3 ./ sumE4;
    
    s = sum(A_estimate,2);
    for k = 1:K
        for kk = 1:K
            A_estimate(k,kk) = A_estimate(k,kk) / s(k);
        end
    end
    s = sum(E_estimate,2);
    for k = 1:K
        for e = 1:EE
            E_estimate(k,e) = E_estimate(k,e) / s(k);
        end
    end
    A_guess = A_estimate;
    E_guess = E_estimate;
end



end