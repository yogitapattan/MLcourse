function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
%X = [ones(m,1) X];
a1=X;
a1 = [ones(m,1) a1];
hid = sigmoid(a1 * Theta1');

hid = [ones(m,1) hid];
a2 = hid;
output = sigmoid(hid * Theta2');

hx = 1:num_labels;
out = zeros(size(y,1),num_labels);
for i = 1:size(y,1)
  out(i,:) = hx == y(i);
endfor

Theta1(:,[1]) = [];
Theta2(:,[1]) = [];
% You need to return the following variables correctly 
J = 0;

J = (1/m) * sum(sum(-out .* log(output) - (1-out) .* log(1-output)),2);
reg = (lambda/(2*m)) *(sum(sum( Theta1.^2),2) + sum(sum( Theta2.^2),2));
J=J+reg;
%J = (1/m) * sum(-log(output) * out' - log(1-output)*(1-out'));
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

Theta1 = [ones(size(Theta1,1),1) Theta1];%size(Theta1)
Theta2 = [ones(size(Theta2,1),1) Theta2];%size(Theta2)

Delta3 = output - out;
Delta2 = Delta3*Theta2 .*a2 .*(1-a2);
Delta2(:,[1])=[];
size(Delta2);

%Delta2 = Delta2(2:end);
%Delta2 = reshape(


CDelta1 = 0;
CDelta1 =  (Delta2' * a1);
CDelta2 = (Delta3' * a2 );

%Theta1(:,[1]) = [];
%Theta2(:,[1]) = [];

Theta1_grad = (1/m) * CDelta1 + (lambda/m)*[zeros(size(Theta1,1),1) Theta1(:,2:end)];
Theta2_grad = (1/m) * CDelta2 + (lambda/m)*[zeros(size(Theta2,1),1) Theta2(:,2:end)];



grad = [Theta1_grad(:) ; Theta2_grad(:)];




% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%



















% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
