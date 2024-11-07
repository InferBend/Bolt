bolt > linear_model > \_linearRegression

# LinearRegression

The `LinearRegression` implements a linear regression model trained using the gradient descent algorithm. This model finds the optimal linear relationship between input features and target values by iteratively minimizing the error between predictions and actual values.

## Overview

Linear Regression with gradient descent is a foundational machine learning algorithm that fits a straight line (or hyperplane) to the data by adjusting model weights iteratively. Gradient descent is used here to minimize the Mean Squared Error (MSE) loss, making it suitable for large datasets and continuous-valued outputs.

## Parameters

### `LinearRegression/fit(x: List[List[f24]], y: List[f24], max_iter: u24, learning_rate: f24, tol: f24)`

- **x**: Training data, a list of lists where each sublist represents a feature vector of type `f24`.
- **y**: Target values, a list of continuous values corresponding to each feature vector in `x`, type `f24`.
- **max_iter**: Maximum number of iterations to run the gradient descent algorithm, type `u24`.
- **learning_rate**: Step size for each iteration of gradient descent, determining how much the weights are adjusted per step, type `f24`.
- **tol**: Tolerance for convergence. If the change in the loss is smaller than `tol`, gradient descent will stop early, type `f24`.

**Returns**: A fitted `LinearRegression` model.

### `LinearRegression/predict(model: LinearRegression, x: List[List[f24]])`

- **model**: A fitted `LinearRegression` instance.
- **x**: Input data for prediction, a list of lists where each sublist represents a feature vector, type `f24`.

**Returns**: Predicted continuous values as an array, with each element corresponding to a prediction for each data sample in `x`.

## Model Attributes

Once the model is trained using LinearRegression/fit, it has the following attributes:

- **weights**: A list of coefficients (one per feature) that define the slope of the line (or hyperplane) fitted to the data, type f24. These weights are adjusted by gradient descent to minimize error.
- **bias**: A single float value representing the intercept, or the value at which the fitted line crosses the y-axis when all feature values are zero. The bias term is also updated during training.
- **cost**: List of Mean Squared Error (MSE) value achieved by the model after each epoch. This value reflects the degree of error in the model's predictions.

## Examples

### Basic Usage

```python
# Training data
x = [
    [7.0, 99.0, 9.0],
    [4.0, 82.0, 4.0],
    [8.0, 51.0, 7.0],
    [5.0, 52.0, 5.0],
    [7.0, 75.0, 8.0],
    [3.0, 78.0, 9.0],
]
y = [91.0, 68.777, 45.0, 36.0, 66.0, 61.0]

# Gradient descent parameters
max_iter = 100
learning_rate = 0.0001
tol = 0.0001

# Fit the Linear Regression model
model = LinearRegression/fit(x, y, max_iter, learning_rate, tol)

# Define test data for prediction
xn = [
    [9.0, 100.0, 3.0],
    [1.0, 60.0, 7.0]
]

# Predict target values for test data
y_pred = LinearRegression/predict(model, xn)
# Output: Predicted Values: [predicted_value1, predicted_value2]
```

### Accessing Model Attributes

After fitting the model, you can access these attributes to understand the learned parameters:

```python
model = LinearRegression/fit(x, y, max_iter, learning_rate, tol)

# Accessing model weights, bias, and cost
match model:
  case LinearRegression/Model:
    IO/print(model.weights)
    IO/print(model.bias)
    IO/print(model.cost)

```

## Explanation of Gradient Descent Parameters

- **max_iter**: Increasing `max_iter` can improve accuracy but may slow down training.
- **learning_rate**: Too high of a learning rate might lead to divergence, while too low of a learning rate could result in slow convergence.
- **tol**: Useful for setting an early stopping criterion, speeding up training when the error improvement becomes minimal.

## Common Issues and Error Handling

- **Learning Rate Too High**: If the learning rate is too high, gradient descent may diverge. Start with a small learning rate and adjust as needed.
- **Insufficient `max_iter`**: If the model doesn't converge within the specified iterations, try increasing `max_iter` or adjusting the `learning_rate`.
- **Imbalanced Features**: Standardize or normalize features if there are large variations in feature scales, as this improves gradient descent performance.
