README: Predicting Employee Turnover at Salifort Motors


Overview

The goal of this project was to develop a machine learning model to predict employee turnover at Salifort Motors, a fictional French-based alternative energy vehicle manufacturer with over 100,000 employees globally. The project compared Decision Tree and Random Forest classifiers to identify which factors most strongly predict whether an employee will leave the company. The Random Forest model slightly outperformed the Decision Tree model, with last_evaluation, number_project, tenure, and overworked emerging as the most influential predictors. Based on the analysis, the model provides actionable insights for HR to improve employee retention through workload management, promotion policies, and evaluation practices.


Business Understanding

Employee turnover is costly—recruiting, hiring, and training new employees requires significant time and resources. For a global company like Salifort Motors, understanding why employees leave enables proactive intervention before valuable talent departs.
This project aimed to answer a critical business question: What factors are most likely to make an employee leave the company?
The value of an accurate predictive model extends beyond identification of at-risk employees. By understanding the key drivers of turnover, HR leadership can implement targeted policy changes to address systemic issues, ultimately improving retention, employee satisfaction, and organizational performance.


Feature Engineering

An overworked feature was engineered from average_montly_hours to flag employees working excessive hours (200+ hours per month), which proved to be one of the most important predictors in the final model.


Modeling and Evaluation

Since the target variable (left) is categorical, the project evaluated two tree-based classification approaches: Decision Tree and Random Forest.


Model Comparison

Both models were trained and evaluated using cross-validation to determine which better predicted employee turnover. Both achieved strong performance.

Decision Tree: 
- Precision: 85.7%
- Recall: 90.4%
- F1 Score: 87.9%
- Accuracy: 95.9%
- AUC: 95.9%

Random Forest
- Precision: 86.7%
- Recall: 87.9%
- F1 Score: 87.2%
- Accuracy: 95.7%
- AUC: 96.5%

The Random Forest model achieved higher AUC (96.5%) and precision (86.7%), indicating better overall discrimination and fewer false positives. The Decision Tree model achieved higher recall (90.4%), capturing more employees who actually left. Both models demonstrate strong predictive capability with accuracy above 95%.


Feature Importance

The models identified the following variables as most predictive of employee turnover:

Decision Tree — Top Features:
- number_project
- last_evaluation
- tenure
- overworked

Random Forest — Top Features:
- last_evaluation
- number_project
- tenure
- overworked
- work_accident
- salary_low

Both models consistently identified performance evaluation scores, project workload, tenure, and overwork status as the primary drivers of employee departure.


Conclusion

This model enables HR to predict which employees are at risk of leaving and, more importantly, understand why they leave. The analysis revealed several actionable patterns:


Key Findings

- Evaluation scores matter: last_evaluation was the top predictor in the Random Forest model, suggesting a complex relationship between performance reviews and turnover
- Project overload drives attrition: High numbers of projects correlate with employee departure
- The 4-year tenure cliff: Employees at approximately 4 years tenure show elevated turnover risk
- Overwork is unsustainable: Employees working 200+ hours monthly are significantly more likely to leave
- Low salary increases risk: salary_low appeared among the top predictors, confirming compensation's role in retention


Recommendations for HR

- Cap the number of projects employees can work on simultaneously
- Investigate why employees at 4-year tenure are dissatisfied—consider promotion pathways or role development opportunities
- Either reward employees for working longer hours or eliminate the expectation of overtime
- Clarify overtime pay policies and workload expectations across the organization
- Revisit evaluation practices—high evaluation scores should not be reserved exclusively for employees working 200+ hours per month
- Hold company-wide discussions to address work culture issues


Next Steps

The model provides a foundation for proactive retention efforts. Future iterations could incorporate additional data such as employee engagement survey responses, manager quality metrics, or exit interview themes to further refine predictions and recommendations.



