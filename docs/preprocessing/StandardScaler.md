bolt > preprocessing > _StandardScaler
# StandardScaler

The `StandardScaler` class provides methods for scaling features to a standard normal distribution. It is commonly used to standardize features in data preprocessing, transforming the data to have a mean of 0 and a standard deviation of 1.

## Overview

Standard scaling is a crucial step in many machine learning pipelines, as it ensures that features have consistent scale, which can help gradient-based algorithms converge more quickly. The `StandardScaler` computes the mean and standard deviation of each feature and applies transformations to make the data conform to a normal distribution.
Here’s the mathematical formula for standard scaling, which can be added to the documentation in Markdown format:

## Standard Scaling Formula

The `StandardScaler` transforms each feature \( x_i \) in the dataset to have a mean of 0 and a standard deviation of 1. The scaling formula is given by:

$`
x_{\text{scaled}} = \frac{x - \mu}{\sigma}
`$

where:
- \( x \) is the original feature value.
- \( \mu \) is the mean of the feature across all samples.
- \( \sigma \) is the standard deviation of the feature.

For inverse scaling, we use:

$`
x_{\text{original}} = x_{\text{scaled}} \times \sigma + \mu
`$

This formula allows us to revert the scaled data back to its original values.

---

This should give users a clearer understanding of the standard scaling and inverse scaling transformations.

## Parameters

### `standard_scaler(x: List[List[f24]])`

- **x**: Input data, a list of lists where each sublist represents a feature vector, type `f24`.

**Returns**: A fitted `StandardScaler` model, containing computed statistics (mean and standard deviation) for each feature.

### `transform(x: List[List[f24]], model: StandardScaler, direction: i24)`

- **x**: Data to transform, a list of lists where each sublist represents a feature vector, type `f24`.
- **model**: A fitted `StandardScaler` instance.
- **direction**: An integer (1 or -1) specifying the direction of scaling:
  - **1** for standard scaling, i.e., to apply the transformation based on the computed mean and standard deviation.
  - **-1** for inverse scaling, i.e., to revert the scaled data back to its original values.

**Returns**: Scaled or inversely scaled data, a list of lists in the same shape as `x`.

---

## Model Attributes

After fitting the model using `standard_scaler`, the following attributes become available:

- **featureMean**: A list of mean values, one per feature, computed from the input data. Used as the central tendency for scaling.
- **stddev**: A list of standard deviation values, one per feature, computed from the input data. Used to scale each feature to a standard deviation of 1.

### Accessing Model Attributes

After the `StandardScaler` model is fitted, you can access these attributes to understand the computed statistics:

```python
model = standard_scaler(x)

# Accessing model mean and standard deviation
with IO:
  IO/print("Mean:", model.featureMean)
  IO/print("Standard Deviation:", model.stddev)
```

---

## Examples

### Basic Usage

```python
# Sample data
x = [
    [1.0, 2.0],
    [10.0, 5.0]
]

# Fit the Standard Scaler model to data
model = standard_scaler(x)

# Transform the data using standard scaling
res = transform(x, model, 1)
print("Standard Scaled Data:", res)

# Inverse transform the scaled data to return to original scale
out = transform(res, model, -1)
print("Inversely Scaled Data (Original Data):", out)

# Outputs:
# Standard Scaled Data: [[-1.0, -1.0], [1.0, 1.0]]
# Inversely Scaled Data (Original Data): [[1.0, 2.0], [10.0, 5.0]]
```

---

## Explanation of Transformation Parameters

- **direction = 1**: Standard scaling applies the transformation by subtracting the mean and dividing by the standard deviation of each feature.
- **direction = -1**: Inverse scaling reverses the transformation by multiplying by the standard deviation and adding the mean back, effectively reconstructing the original data.

---

## Common Issues and Error Handling

- **Unfitted Model**: Attempting to transform data with an unfitted model will result in errors. Ensure you run `standard_scaler(x)` first.
- **Feature Scaling for Gradient-Based Algorithms**: For gradient-based algorithms, it's recommended to use standard scaling as it helps prevent features with larger scales from dominating the learning process.
