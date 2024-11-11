bolt > linear_models > _logisticRegression
# LogisticRegression

The `LogisticRegression` class implements a logistic regression model trained using gradient descent. This model is designed for binary classification tasks, predicting the probability that a given input belongs to a specific class by learning the optimal decision boundary between the classes.

## Overview

Logistic Regression is a widely used statistical method for binary classification that outputs probabilities for each class. The model applies the sigmoid function to transform linear predictions into probabilities, making it ideal for predicting binary outcomes.

## Parameters

### `LogisticRegression/fit(x: List[List[f24]], y: List[f24], max_iter: u24, learning_rate: f24, tol: f24)`

- **x**: Training data, a list of lists where each sublist represents a feature vector of type `f24`.
- **y**: Target values, a list of binary values (e.g., 0 or 1) corresponding to each feature vector in `x`, type `f24`.
- **max_iter**: Maximum number of iterations to run the gradient descent algorithm, type `u24`.
- **learning_rate**: Step size for each iteration of gradient descent, determining the magnitude of updates to the weights and bias, type `f24`.
- **tol**: Tolerance for convergence; if the change in loss is less than `tol`, the algorithm stops early, type `f24`.

**Returns**: A fitted `LogisticRegression` model.

### `LogisticRegression/predict(model: LogisticRegression, x: List[List[f24]])`

- **model**: A fitted `LogisticRegression` instance.
- **x**: Input data for prediction, a list of lists where each sublist represents a feature vector, type `f24`.

**Returns**: Predicted class labels (0 or 1) for each data sample in `x`.

## Model Attributes

After fitting the model using `LogisticRegression/fit`, the following attributes become available:

- **weights**: A list of coefficients (one per feature) that define the slope of the decision boundary for classification, type `f24`. These weights are optimized by gradient descent.
- **bias**: A single float value representing the intercept of the decision boundary, type `f24`.
- **cost**: The final Binary Cross-Entropy loss (cost) achieved by the model after training. This value reflects the degree of error in the model's predictions.

### Accessing Model Attributes

After training, you can inspect the model’s learned parameters:

```python
model = LogisticRegression/fit(x, y, max_iter, learning_rate, tol)

# Accessing model weights, bias, and cost
match model:
  case LogisticRegression/Model:
    IO/print(model.weights)
    IO/print(model.bias)
    IO/print(model.cost)
```

## Examples

### Basic Usage

```python
# Training data
x = [
    [7.0, 2.0],
    [3.0, 4.0],
    [1.0, 6.0],
    [6.0, 1.0],
    [3.0, 5.0],
    [4.0, 2.0],
]
y = [1.0, 0.0, 1.0, 0.0, 1.0, 0.0]

# Gradient descent parameters
max_iter = 100
learning_rate = 0.01
tol = 0.001

# Fit the Logistic Regression model
model = LogisticRegression/fit(x, y, max_iter, learning_rate, tol)

# Define test data for prediction
xn = [
    [5.0, 3.0],
    [2.0, 7.0]
]

# Predict class labels for test data
y_pred = LogisticRegression/predict(model, xn)
# Output: Predicted Class Labels: [0.0, 1.0]
```

## Common Issues and Error Handling

- **Divergence**: If the learning rate is too high, gradient descent may not converge. Try a smaller learning rate.
- **Non-convergence within max_iter**: If the model doesn’t converge, increase `max_iter` or adjust `learning_rate`.
- **Feature Scaling**: Standardize or normalize features to improve gradient descent efficiency, especially with large variations in feature scales.

---