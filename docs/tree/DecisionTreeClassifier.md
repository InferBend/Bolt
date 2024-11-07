bolt > trees > _decisionTree
# DecisionTree

The `DecisionTree` class implements a decision tree classifier, which recursively splits data based on feature values to create a tree structure. The model can then use this tree structure to classify new samples by following the decision paths from root to leaf.

## Overview

Decision trees are intuitive models for classification tasks. They work by creating a series of binary splits on features, aiming to maximize the separation between classes at each step. This results in a tree of decision nodes and leaf nodes representing final classifications. 

A key metric often used in decision trees is **entropy**, which measures the impurity or uncertainty in a dataset. 

## Entropy and Information Gain

In decision trees, **entropy** quantifies the impurity in the data at each node. Lower entropy indicates a purer node (i.e., a node where most data points belong to a single class). The tree-building process uses **information gain**, calculated from entropy, to decide which feature to split on at each node.

### Entropy Formula

For a set of classes $` C = \{c_1, c_2, \ldots, c_k\} `$, where $` p(c_i) `$ is the proportion of data points in class $` c_i `$ at a given node, the entropy $` H `$ at that node is defined as:

$`
H(C) = - \sum_{i=1}^{k} p(c_i) \cdot \log_2(p(c_i))
`$

where:
- $` p(c_i) `$ is the probability of class $` c_i `$ within the node.
- $` \log_2 `$ is the base-2 logarithm.

A node with only one class will have an entropy of 0 (completely pure), while a node with an equal mix of classes will have the highest entropy.

### Information Gain

When a split is made based on a feature, **information gain** calculates the reduction in entropy. Higher information gain means the split yields a purer separation between classes. It’s given by:

$`
\text{Information Gain} = H(\text{parent}) - \left( \frac{n_{\text{left}}}{n} \cdot H(\text{left}) + \frac{n_{\text{right}}}{n} \cdot H(\text{right}) \right)
`$

where:
- $` H(\text{parent}) `$ is the entropy of the parent node.
- $` H(\text{left}) `$ and $` H(\text{right}) `$ are the entropies of the left and right child nodes.
- $` n_{\text{left}} `$ and $` n_{\text{right}} `$ are the number of samples in the left and right child nodes.
- $` n `$ is the total number of samples in the parent node.

---

## Parameters

### `DecisionTree/fit(X: List[List[f24]], y: List[f24], max_depth: u24, min_samples_split: u24)`

- **X**: Training data, a list of lists where each sublist represents a feature vector, type `f24`.
- **y**: Target values, a list of labels corresponding to each feature vector in `X`, type `f24`.
- **max_depth**: Maximum depth of the tree. Limits the number of splits to prevent overfitting, type `u24`.
- **min_samples_split**: Minimum number of samples required to split a node. Restricts splits on small nodes to avoid overfitting, type `u24`.

**Returns**: A fitted `DecisionTree` model.

### `DecisionTree/predict(model: DecisionTree, x: List[List[f24]])`

- **model**: A fitted `DecisionTree` instance.
- **x**: Input data for prediction, a list of lists where each sublist represents a feature vector, type `f24`.

**Returns**: Predicted class labels for each data sample in `x`.

---

## Model Attributes

After fitting the model using `DecisionTree/fit`, the following attributes define the structure of the tree:

- **Node**: Represents an internal decision node in the tree with the following attributes:
  - **feature**: The index of the feature used for splitting at this node.
  - **threshold**: The value of the feature at which the split occurs.
  - **~left**: Reference to the left child node, where samples meeting the split condition are sent.
  - **~right**: Reference to the right child node, where samples not meeting the split condition are sent.
  
- **Leaf**: Represents a terminal leaf node with the following attribute:
  - **value**: The predicted class label or probability for samples reaching this leaf.

### Accessing Model Attributes

Once the model is trained, you can traverse the tree’s structure to inspect the decision nodes and leaf nodes:

```python
model = DecisionTree/fit(X, y, max_depth, min_samples_split)

with IO:
    match model:
        case DecisionTree/Node:
            IO/print("Root Node Feature:", model.feature)
            IO/print("Root Node Threshold:", model.threshold)
        case DecisionTree/Leaf:
            IO/print("Root Node Feature:", model.value)
```

## Examples

### Basic Usage

```python
# Training data
X = [
    [2.5, 3.1],
    [1.2, 7.8],
    [3.3, 6.5],
    [1.7, 2.8],
    [3.1, 5.4],
    [4.0, 1.2],
]
y = [0.0, 1.0, 1.0, 0.0, 1.0, 0.0]

# Decision Tree parameters
max_depth = 3
min_samples_split = 2

# Fit the Decision Tree model
model = DecisionTree/fit(X, y, max_depth, min_samples_split)

# Define test data for prediction
x_test = [
    [3.0, 4.0],
    [1.5, 6.0]
]

# Predict class labels for test data
y_pred = DecisionTree/predict(model, x_test)

print("Predicted Class Labels:", y_pred)
# Output: Predicted Class Labels: [predicted_label1, predicted_label2]
```

---

## Explanation of Tree Parameters

- **max_depth**: Limits the depth of the tree to prevent overfitting. Shallow trees may underfit, while deep trees may overfit to the training data.
- **min_samples_split**: Ensures each node has a minimum number of samples before being split. Higher values create broader splits, reducing overfitting.

---

## Tree Structure and Traversal

Each decision node in the tree splits data based on a feature value:  
  
$`
\text{if } x_{\text{feature}} \leq \text{threshold, go to left child; else, go to right child.}
`$

Once a sample reaches a leaf node, the leaf node’s **value** is used as the predicted class for that sample.

---

## Common Issues and Error Handling

- **Overfitting**: High `max_depth` or low `min_samples_split` may cause overfitting, capturing noise in the training data.
- **Underfitting**: Low `max_depth` or high `min_samples_split` may cause underfitting, missing important patterns in the data.
- **Imbalanced Classes**: For imbalanced data, consider limiting tree depth or applying class weights to ensure fair representation.

---
