bolt > model_selection > _train_test_split
# train_test_split

The `train_test_split` function splits datasets into training and testing subsets. It provides an easy way to evaluate machine learning models on unseen data by separating a portion of the dataset for validation or testing.

## Overview

This function splits input arrays into random train and test subsets while maintaining the structure of input arrays. It allows customization of the test size, shuffling of data, and reproducibility through a random state.

---

## Parameters

### `train_test_split(arrays: List, test_size: f24, shuffle: u8, random_state: f24)`

- **arrays**: A list of arrays to be split. Each array should have the same length (number of samples). Typically includes features (`X`) and target labels (`y`).
  
- **test_size**: Fraction of the dataset to allocate for testing. Must be a float between 0 and 1. For example, `test_size = 0.25` reserves 25% of the data for testing.
  
- **shuffle**: A binary flag (`0` or `1`) indicating whether to shuffle the data before splitting. Set to `1` to shuffle the data and `0` to retain the original order.
  
- **random_state**: A float seed value used for random number generation. Ensures reproducibility of the shuffle when `shuffle` is enabled. The same `random_state` will produce the same train-test split across runs.

**Returns**: A list of arrays split into train and test subsets. The order of the arrays matches the input, with the first half of the arrays corresponding to the training set and the second half to the testing set.

---

## Examples

### Splitting a Dataset

```python
# Input feature matrix and target labels
X = [[1.0, 2.0, 3.0], [4.0, 5.0, 6.0], [7.0, 8.0, 9.0], [10.0, 11.0, 12.0], [13.0, 14.0, 15.0]]
y = [1.0, 2.0, 3.0, 4.0, 5.0]

# Split data with 25% for testing, shuffled, and a fixed random state
dataset = train_test_split([X, y], 0.25, 1, 1.0)

# Extract training and testing subsets
X_train, X_test = List/index(dataset, 0)
y_train, y_test = List/index(dataset, 1)

# Results
with IO:
    IO/print("Training Features:", X_train)
    IO/print("Testing Features:", X_test)
    IO/print("Training Labels:", y_train)
    IO/print("Testing Labels:", y_test)
```

---

## Explanation of Parameters

1. **Test Size**: Defines the proportion of the data to reserve for testing. For example:
   - `test_size = 0.2`: 80% training, 20% testing.
   - `test_size = 0.5`: 50% training, 50% testing.

2. **Shuffle**: If set to `1`, the data is shuffled randomly before splitting. If `0`, the data remains in its original order.

3. **Random State**: Ensures consistent splits when `shuffle` is enabled. For instance, using `random_state = 1.0` will always produce the same shuffle and split.

---

## Common Issues and Error Handling

1. **Mismatched Array Lengths**: Ensure that all arrays in the `arrays` parameter have the same number of samples. Mismatched lengths will raise an error.
   
2. **Test Size Range**: `test_size` must be a float between `0` and `1`. Values outside this range will result in an error.
   
3. **Shuffle Disabled with Random State**: If `shuffle = 0`, the `random_state` parameter has no effect.

---

## Use Cases

- Splitting datasets into training and testing subsets for model evaluation.
- Creating validation sets for hyperparameter tuning.
- Ensuring consistent splits for debugging and reproducibility.

---