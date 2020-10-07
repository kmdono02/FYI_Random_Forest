library(randomForest)
library(DMwR)
library(pROC)
library(caret)

load("rf_ASD_final.Rdata")

rf_ASD_predict <- function(dataset, thres="best"){
  rf_predict_probs <- predict(rf_ASD_final, data=dataset, type = "prob")
  dataset_string <- paste("dataset", "$", "Groups_2", sep="")
  rf_predict_roc <- roc(response=eval(parse(text=dataset_string)),
                        predictor=rf_predict_probs[,2])
  if(thres=="best"){
    best_rf_thres <- coords(rf_predict_roc,
                            x="best", ret="threshold",
                            best.method = "closest.topleft")
    rf_predict_classes <- factor(ifelse(rf_predict_probs[,2]>
                                          rep(best_rf_thres[1],
                                              length(rf_predict_probs[,2])),
                                        "HR_ASD", "HR_Neg"))
  }else{
    rf_predict_classes <- factor(ifelse(rf_predict_probs[,2]>
                                          rep(thres,
                                              length(rf_predict_probs[,2])),
                                        "HR_ASD", "HR_Neg"))
  }
  output <- list("rf_predicted_probabilities" = rf_predict_probs, "rf_predicted_classes" = rf_predict_classes,
                 "rf_confusion_matrix" = confusionMatrix(data=rf_predict_classes,
                                                         reference=eval(parse(text=dataset_string)),
                                                         positive="HR_ASD"),
                 "rf_roc_object" = rf_predict_roc, "rf_auc" = pROC::auc(rf_predict_roc),
                 "rf_roc_plot" = plot(rf_predict_roc))
  return(output)
}

rf_predict_obj <- rf_ASD_predict(dataset=dataset_HR_RF_SMOTE)
