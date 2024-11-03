bolt > metrics > _Classification
# Classification

These metrics provide essential tools for evaluating the performance of classification models.

# accuracy_score

The `accuracy_score` metric calculates the accuracy of a classification model by comparing the predicted labels to the true labels. It’s defined as the ratio of the number of correct predictions to the total number of predictions, making it a commonly used metric for evaluating classification performance.

## Overview

Accuracy is a simple but effective metric, especially for balanced datasets where classes are evenly represented. It’s calculated as:

\[
\text{Accuracy} = \frac{\text{Number of Correct Predictions}}{\text{Total Number of Predictions}}
\]

This function is ideal for quick model evaluation and gives an immediate sense of how well the model performs on a given dataset.

## Parameters

### `accuracy_score(yTrue: List[f24], yPred: List[f24])`

- **yTrue**: List of true target values, with each element representing the correct label for a corresponding sample, type `f24`.
- **yPred**: List of predicted target values, with each element representing the label predicted by the model for a corresponding sample, type `f24`.

**Returns**: The accuracy of the model, calculated as a float between `0.0` (no correct predictions) and `1.0` (all predictions correct).

## Examples

### Basic Usage

```python
# True labels
y_true = [0.0, 1.0, 0.0, 1.0]

# Predicted labels
y_pred = [0.0, 1.0, 1.0, 1.0]

# Calculate accuracy
accuracy = accuracy_score(y_true, y_pred)
# Output: accuracy: 0.75
```

## Common Issues and Error Handling

- **Mismatched Lengths**: Ensure `yTrue` and `yPred` have the same length, as the function requires one-to-one correspondence between true and predicted labels.
- **Imbalanced Classes**: On highly imbalanced datasets, accuracy might be misleading. Consider additional metrics, such as precision, recall, or F1 score, for a more comprehensive evaluation.