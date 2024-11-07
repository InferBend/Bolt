bolt > neighbors > _KNeighborsRegressor
# KNeighborsRegressor

The `KNeighborsRegressor` provides a regression algorithm based on the k-nearest neighbors approach. For each input, it identifies the `k` closest data points in the training set and predicts the output by averaging their values.

## Parameters

### `Knn/fit(X: List[List[f24]], y: List[f24], n_neighbors: u24, p: f24)`

- **X**: Training data, a list of lists where each sublist represents a feature vector of type `f24`.
- **y**: Target values, a list of numeric values associated with each feature vector in X, type f24..
- **n_neighbors**: The number of neighbors to consider for classification (k value), type `u24`.
- **p**: The power parameter for the Minkowski metric. When `p = 1`, this uses the Manhattan distance (L1), and when `p = 2`, it uses the Euclidean distance (L2). Type `f24`.

**Returns**: A fitted `KNeighborsRegressor` instance.

### `Knn/predict(model: KNeighborsRegressor, X_test: List[List[f24]])`

- **model**: A fitted `KNeighborsRegressor` instance.
- **X_test**: Test data, a list of lists where each sublist represents a feature vector, type `f24`.

**Returns**: Predicted continuous values for each data sample in X_test, as an array with shape (n_queries,).

## Example Usage

```python
X = [[5.0, 3.0], [3.0, 2.0], [1.5, 9.0], [7.0, 2.0]]
y = [0.0, 1.0, 0.0, 1.0]
k = 5
p = 2.0

# Fit the KNeighborsRegressor model
model = Knn/fit(X, y, k, p)

# Define test data
X_test = [[2.0, 7.0], [5.0, 3.0]]

# Predict class labels for test data
y_pred = Knn/predict(model, X_test)
```

### Tuning Tips

- **Choosing `k`**: Larger `k` values reduce sensitivity to noise but may smooth out decision boundaries. Typical values are between 3 and 10.
- **Choosing `p`**: Experiment with `p=1` and `p=2` initially to see which metric works best. Higher values may result in less interpretable metrics.