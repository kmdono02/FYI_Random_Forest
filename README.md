# FYI Random Forest Algorithm
Random Forest algorithm using the First Year Inventory (FYI) responses for predicting Autism Spectrum Disorder (ASD) diagnosis in high risk infants referenced in "Towards A Data Driven Approach To Screen For Autism Risk At 12 Months Of Age" by Meera et al. (2019)

# Contents
1. Analysis Script

The script to replicate all analyses done in Meera et al. (2019) is provided as R Markdown file **FYI_Analysis_Script_V4.Rmd**, including the creation of all demographic and summary statistics, all ANOVA analyses (including some not included in the manuscript or supplemental material), high risk (HR) sample Random Forest analysis with repeated k-fold cross validation, testing HR derived Random Forest on low risk ASD negative (LR-Neg) sample, and FYI Lite analysis.

2. Random Forest algorithm

The Random Forest algorithm generated from the entire HR sample is provided for use on an aribitrary dataset as an R object titled **rf_ASD_final.RData**.  

3. Function to run Random Forest

While one can create their own script to use the algortihm saved in rf_ASD_final.RData, the script **rf_ASD_predict.R** is included.  The script consists of the R function **rf_ASD_predict** and all required packages to run this function.  This function takes a provided dataset, predicts the ASD diagnoses in the dataset using the Random Forest algorthim in rf_ASD_final.RData at a specified probability threshold, and outputs the following as an R list:
  * rf_predicted_probabilities: Predicted probabilities of ASD diagnosis for each subject in the dataset
  * rf_predicted_classes: Predicted ASD diagnosis for each subject in the dataset based on chosen probability threshold
  * rf_confusion_matrix: Corresponding confusion matrix for dataset of predicted vs. actual ASD diagnosis
  * rf_roc_object: ROC curve object for predictions
  * rf_auc: AUC for ROC curve
  * rf_roc_plot: Plotted ROC curve for predictions
  
The default threshold is set to the threshold corresponding most upper-left point on the ROC curve.  Also, all FYI variables need to be named "FYIq_x" where x is the question number, the variable denoting ASD diagnosis needs to be named "Groups_2", and this variable needs to have values "HR_ASD" for ASD positive diagnoses and "HR_Neg" for ASD negative diagnosis.


