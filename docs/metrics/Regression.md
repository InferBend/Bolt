bolt > metrics > _Regression
# Regression Metrics

These metrics provide essential tools for evaluating the performance of regression models. Each metric measures error or fit quality differently, offering unique insights into model performance.

---

## meanSquaredError

The `meanSquaredError` (MSE) metric calculates the average squared difference between predicted and actual values, making it useful for measuring the magnitude of prediction errors. Larger errors are penalized more heavily due to the squaring, making this metric sensitive to outliers.

### Parameters

- **yTrue**: List of true target values, each representing the correct continuous value for a corresponding sample, type `f24`.
- **yPred**: List of predicted target values, each representing the continuous value predicted by the model for a corresponding sample, type `f24`.

**Returns**: The mean squared error as a float.

### Formula

$`
\text{MSE} = \frac{1}{n} \sum_{i=1}^{n} (y_{\text{true},i} - y_{\text{pred},i})^2
`$

### Example

```python
y_true = [3.0, -0.5, 2.0, 7.0]
y_pred = [2.5, 0.0, 2.0, 8.0]

mse = meanSquaredError(y_true, y_pred)
# Output: mse: 0.375
```

---

## meanAbsoluteError

The `meanAbsoluteError` (MAE) metric calculates the average absolute difference between predicted and actual values, providing a straightforward measure of error without penalizing larger errors as much as MSE. It’s useful for models where you want to interpret errors in absolute terms.

### Parameters

- **yTrue**: List of true target values, type `f24`.
- **yPred**: List of predicted target values, type `f24`.

**Returns**: The mean absolute error as a float.

### Formula

$`
\text{MAE} = \frac{1}{n} \sum_{i=1}^{n} |y_{\text{true},i} - y_{\text{pred},i}|
`$

### Example

```python
y_true = [3.0, -0.5, 2.0, 7.0]
y_pred = [2.5, 0.0, 2.0, 8.0]

mae = meanAbsoluteError(y_true, y_pred)
# Output: mae: 0.5
```

---

## r2_score

The `r2_score` (R-squared) metric, also known as the coefficient of determination, indicates the proportion of variance in the dependent variable that is predictable from the independent variable(s). It ranges from `0.0` to `1.0`, with higher values indicating a better fit.

### Parameters

- **yTrue**: List of true target values, type `f24`.
- **yPred**: List of predicted target values, type `f24`.

**Returns**: The R-squared score as a float, where values closer to `1.0` indicate better model performance.

### Formula

$`
R^2 = 1 - \frac{\text{Sum of Squared Errors (SSE)}}{\text{Total Sum of Squares (TSS)}}
`$

where:
- **SSE** is the sum of squared errors, calculated as $`\sum (y_{\text{true}} - y_{\text{pred}})^2`$.
- **TSS** is the total sum of squares, calculated as $`\sum (y_{\text{true}} - \text{mean}(y_{\text{true}}))^2`$.

### Example

```python
y_true = [3.0, -0.5, 2.0, 7.0]
y_pred = [2.5, 0.0, 2.0, 8.0]

r2 = r2_score(y_true, y_pred)
# Output: r2_score: 0.948
```

---

## totalSumOfSquares

The `totalSumOfSquares` (TSS) metric provides a measure of the total variance of the true target values. It serves as a baseline metric to compare against the sum of squared errors (SSE) for computing metrics like `r2_score`.

### Parameters

- **yTrue**: List of true target values, type `f24`.

**Returns**: The total sum of squares as a float.

### Formula

$`
\text{TSS} = \sum_{i=1}^{n} (y_{\text{true},i} - \text{mean}(y_{\text{true}}))^2
`$

### Example

```python
y_true = [3.0, -0.5, 2.0, 7.0]

tss = totalSumOfSquares(y_true)
# Output: tss: 29.25
```

---

## Common Issues and Error Handling

- **Mismatched Lengths**: Ensure `yTrue` and `yPred` are of the same length for all metrics requiring both.
- **Outliers**: For datasets with extreme values, consider using `MAE` over `MSE` to reduce sensitivity to outliers.
- **Negative R-squared**: In rare cases, `R^2` can be negative, indicating that the model performs worse than a simple mean-based prediction.