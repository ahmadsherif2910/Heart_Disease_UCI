# Heart Disease Detection Project
> This project provides a machine learning solution designed to assist medical professionals in identifying heart disease. By leveraging a high-recall detection algorithm, the tool ensures that potential cases are flagged early, prioritizing patient safety and clinical intervention.
## Model Performance
> The algorithm is optimized for clinical environments where missing a diagnosis (a false negative) carries high risk.
* Recall: **92%** (Optimized to identify the vast majority of true positive cases).
* Overall Accuracy: **88%.**


## How It Works
> The model processes clinical data through a rigorous multi-stage pipeline to ensure the **92%** Recall is both accurate and reliable.



### 1. Data Preprocessing & Feature Engineering
We use a `ColumnTransformer` to handle different types of medical data differently:
* Numerical Features: (Age, BP, Cholesterol, etc.) are processed via `StandardScaler` to ensure all features contribute equally to the distance-based calculations.
* Categorical Features: (Chest Pain type, ECG results, etc.) are transformed using `OneHotEncoder` to make them readable for the algorithm.



### 2. Dimensionality Reduction (PCA)
To remove "noise" from the dataset and prevent overfitting, we apply Principal Component Analysis (PCA).
* We retain **95% of the variance**, which allows the model to focus on the most significant clinical patterns while reducing the complexity of the input data.


### 3. The Classification Engine
After testing multiple architectures (Logistic Regression, Random Forest, XGBoost), the **SVM (Support Vector Machine) with PCA** was selected as the production champion due to its superior performance in identifying positive cases.


| Metric | Score |
| --- | --- |
| Recall (Sensitivity) | 92% |
| ROC-AUC | 0.94 |
| Accuracy | 88% |


### 4. The Prediction Pipeline
The entire process is bundled into a single `pickle` file. This ensures that the exact same scaling and PCA transformations applied during training are applied to the "live" user data in the Streamlit app, preventing "Training-Serving Skew."
```python
# Simplified look at the production pipeline
svm_pipeline_pca = Pipeline(steps=[
    ('preprocessor', preprocessor),
    ('PCA', PCA(0.95)),
    ('svm', SVC(probability=True))
])
```


## Getting Started 

### 1. Clone the Repository

First, download the source code from GitHub:
```bash
git clone https://github.com/ahmadsherif2910/Heart_Disease_UCI.git
```
```bash
cd Heart_Disease_UCI

```
### 2. Build the Docker Image

Run the following command to build the environment. Docker will read the `Dockerfile`, install dependencies from `requirements.txt`, and package the `production/` folder into a virtual container:

```bash
docker build -t heart-disease-app .
```

### 3. Run the Container

Start the virtual application. This command maps the internal port to port 8501 on your local machine, allowing you to access the Streamlit interface via your browser:
```bash
docker run -p 8501:8501 heart-disease-app
```

## Folder Structure
* The `data` folder has the dataset.
* The `development` folder has the steps notebooks.
* The `production` folder has the `full_pipeline` and the `model.pkl`.
