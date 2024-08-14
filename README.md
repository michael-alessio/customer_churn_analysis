# Project Overview

For this project, I explored https://www.kaggle.com/datasets/gsagar12/dspp1/data to perform analysis in order to improve the customer support process. Using tools such as PostgreSQL, Python (Sklearn, Logistic Regression), and Tableau I created an implementation plan to decrease churn by improving customer service systems based on data driven insights.

# Problem

Using the subscription customer case data, uncover insights to improve the customer support process coming into the next year. 

# Data Overview

## Data

For this project I used sample customer data found on Kaggle. The dataset was published by Sagar Ganapaneni and can be found at https://www.kaggle.com/datasets/gsagar12/dspp1/data 

## Description

This dataset is about a subscription-based digital product offering financial advisory. The subscription offers two product types including an annual and monthly subscription. They also provide customer support where customers can reach out for support on product questions or sign-up/cancelation inquiries. This dataset ranges from 2017-2022.

# Structure

The dataset consists of four tables containing information on support cases, customer demographics, and product signup/cancelation dates. These table tables are structured as follows:

![database_structure](https://github.com/user-attachments/assets/0b1b07cd-fbbe-48df-97a6-1e652968abd9)

# Solution

## Goal

My goal is to redesign the structure of the customer support team with an object based approach to best contribute to decreasing customer subscription churn rate.

## Task

In order to implement my proposed solution, my goal is to use a logistic regression ML model to predict every active customer’s probability of churning. Using this, we can segment customers into different risk levels and identify the risk of each incoming support case. From here we can develop the proper customer support team structure and assign higher risk cases to more senior team members. With these higher risk cases being managed by more experienced support team members we should see subscription churn rate decrease as they will be better equipped to solve the customers problems and retain their subscription. 

## Steps

1. Explore data to uncover independent variables for each customer that may have a correlation with the customer churning or not
2. Query data to create a new table consisting of each customer containing all independent variables and whether or not they canceled their subscription
3. Use this table to train a logistic regression model to predict the probability a customer will churn or not based on the independent variables
4. Use the model to predict the probability of canceling their subscription for all active subscribers
5. Use these probabilities to segment active subscribers based on risk of churning
6. Analyze and visualize the prevalence of high risk customer cases and any other insights to create implementation plan with new customer service team structure and scheduling

# Analyzing Independent Variables

## Possible Contributing Variables

1. Gender - The gender of the customer(male/female)
2. Age - The age of the customer
3 Product Type - Whether the customer has an annual or monthly subscription
4. Number of Cases - Number of support cases created by each customer
5. Age of Subscription - Number of days since the customer signed up for a subscription

## Exploring Variables 1-3

To test the effect of the first three variables on whether the customer will churn or not, I created visualizations to compare the distribution of each variable in active customers and customers that churned. Below are the results of this analysis:

![Dashboard 1](https://github.com/user-attachments/assets/2c0fd7b4-e421-4882-b268-cf8b04546f9a)
https://public.tableau.com/views/Customer_Subscription_Analysis_Independent_Variables_1/Dashboard1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link 

From this, we can see that there is minimal impact from these variables on a customer churning. However, after visualizing the other two variables, it is clear that these two are much more influential. 

## Exploring Variables 4&5

To test out the age of subscription, I created a table containing the age of subscription for all churned customers at the time of cancellation and visualized the distribution of these values. For the number of cases I created a stacked bar chart showing the percent of customers that remained active or churned for each amount of cases (0-5).

![Dashboard 1 (2)](https://github.com/user-attachments/assets/ca8b4d9d-9894-462a-8034-6dc706768ad2)
https://public.tableau.com/views/Customer_Subscription_Analysis_Independent_Variables_2/Dashboard12?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

From this, we can see that the both variables do show a correlation, most notably the age of subscription. Significantly more cancellations happen in younger subscriptions which shows that a customer is most at risk of churning early on in their subscription and is significantly less likely to churn as their subscription ages. For a number of cases, although not as significant, we can see a correlation that having more support cases leads a customer to be more likely to churn. With these two variables showing correlations, we should be able to produce probabilities in the model by using these variables. 

# Model Overview

To produce the probabilities of each customer churning, I used Python and SKLearn to train a logistic regression model using the 5 variables described above as independent variables and whether the customer remained active or not as the dependent variable. 

Using this model, I was able to produce the probabilities of remaining active subscribers for each active customer and categorize these characters in three groups. High risk if the probability is below 70%, medium risk if the probability is between 70-80%, and low risk if the probability is above 80%.

# Final Analysis

Using the risk scores and classifications, I was able to perform a deeper analysis on the distribution of risk among the current active subscriber base and the distribution of risk for each case by quarter in 2022. The results of this analysis are below:

![Dashboard 1 (3)](https://github.com/user-attachments/assets/f52e4249-fc09-4e20-82bc-53587b963431)
https://public.tableau.com/views/Customer_Subscription_Analysis_Churn_Risk/Dashboard13?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

# Recommendations

## Takeaways

Based on the analysis, we can see that although the high risk category of subscribers is the minority of the current active subscriber base, they make up a significant amount of the support cases.

## Implementation

To utilize the insights derived from this project, it would be best to restructure the customer service team into 3 main groups. 

1. Training - This should be by far the smallest group as they will be handling all cases coming from the low risk subscriber group. Although this makes up a very small section of the support cases, the low risk nature of these calls would be perfect for new reps in their first month to ramp up to the role and learn the processes/systems.
2. Level 1 - This is going to make up the bulk of the customer service team and will handle the largest amount of incoming cases which are ones from the medium risk subscribers. This should be representatives that are fully trained but not yet managerial level
3. Level 2 - This should consist of customer services managers/team leads and along with the most experienced representative. They will be trained with a retention centric approach and will be handling the high risk cases with the goal of providing the best possible support to retain customers at risk of churning.

## Evaluation

In order to evaluate the success of this new structure, we should be looking at the overall rate of churn and more specifically the churn rate of subscribers classified as high risk. If both of these metrics decrease in the following year, the restructure of the customer service team should be viewed as a success.

## Recommendations for Further Analysis

In order to fine tune the logistic regression model, more data needs to be collected on the customers habits. The accuracy of the model was decreased by the limited amount of data points available. With more data points, we should be able to find more variables with a correlation and increase the accuracy of the churn probabilities. 
