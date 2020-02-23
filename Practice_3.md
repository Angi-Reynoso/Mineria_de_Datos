## Scenario:  
You are a Data Scientist working for a consulting firm.  
One of your colleagues from the Auditing Department has asked you to help them assess the financial statement of 
organization X.  

You have been supplied with two vector of data: mounthly revenue and expenses for the financial year in question. 
Your task is to calculate the following financial matrics:  
  
- profit for each mounth.  
- profit after tax for each month (the tax rate is 30%).  
- profit margin for each month - equal to profit after tax divided by revenue.  
- good months - where the profit after tax was greater than the mean for the year.  
- bad months - where the profit after tax was less then the mean for years.  
- the best month - where the profit after tax was max for the year.  
- the worst month - where the profit after tax was min for the year.  
  
## Data
~~~~
revenue <- c(14574.49, 7606.46, 8611.41, 9175.41, 8058.65, 8105.44, 11496.28, 9766.09, 10305.32, 14379.96, 10713.97, 15433.50)  
expenses <- c(12051.82, 5695.07, 12319.20, 12089.72, 8658.57, 840.20, 3285.73, 5821.12, 6976.93, 16618.61, 10054.37, 3803.96)  
~~~~

## Solution
1. Calculate Profit As The Differences Between Revenue And Expenses  
~~~~
profit <- revenue - expenses
profit
~~~~

2. Calculate Tax As 30% Of Profit And Round To 2 Decimal Points  
~~~~
tax <- round(0.30 * profit, 2)
tax 
~~~~

3. Calculate Profit Remaining After Tax Is Deducted  
~~~~
profit.after.tax <- profit - tax
profit.after.tax
~~~~

4. Calculate The Profit Margin As Profit After Tax Over Revenue  
   - Round To 2 Decimal Points, Then Multiply By 100 To Get %  
~~~~
profit.margin <- round(profit.after.tax / revenue, 2) * 100
profit.margin
~~~~

5. Calculate The Mean Profit After Tax For The 12 Months  
~~~~
mean_pat <- mean(profit.after.tax)
mean_pat
~~~~

6. Find The Months With Above-Mean Profit After Tax  
~~~~
good.months <- profit.after.tax > mean_pat
good.months
~~~~

7. Bad Months Are The Opposite Of Good Months  
~~~~
bad.months <- !good.months
bad.months
~~~~

8. The Best Month Is Where Profit After Tax Was Equal To The Maximum  
~~~~
best.month <- profit.after.tax == max(profit.after.tax)
best.month
~~~~

9. The Worst Month Is Where Profit After Tax Was Equal To The Minimum  
~~~~
worst.month <- profit.after.tax == min(profit.after.tax)
worst.month
~~~~

10. Convert All Calculations To Units Of One Thousand Dollars  
~~~~
revenue.1000 <- round(revenue / 1000, 0)
expenses.1000 <- round(expenses / 1000, 0)
profit.1000 <- round(profit / 1000, 0)
profit.after.tax.1000 <- round(profit.after.tax / 1000, 0)
~~~~

11. Print Results  
~~~~
revenue.1000
expenses.1000
profit.1000
profit.after.tax.1000
profit.margin
good.months
bad.months
best.month
worst.month
~~~~

12. BONUS:  
    - Preview Of What's Coming In The Next Section
~~~~
M <- rbind(
  revenue.1000,
  expenses.1000,
  profit.1000,
  profit.after.tax.1000,
  profit.margin,
  good.months,
  bad.months,
  best.month,
  worst.month
)
~~~~

13. Print The Matrix  
`M`

##### Screen capture with all the variables used:  
<img src="https://github.com/Angi-Reynoso/Mineria_de_Datos/blob/Unidad_1/Images/Practice3-values.png" 
alt="Practice3" width="85%">