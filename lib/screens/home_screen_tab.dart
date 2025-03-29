import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/widget/income_expense_card.dart';
import 'package:personal_finance_tracker/utils/constants.dart';

class HomeScreenTab extends StatelessWidget {
  const HomeScreenTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(defaultSpacing),
        child: Column(
          children: [
            SizedBox(height: defaultSpacing * 4),
            Row(
              children: [
                Expanded(child: IncomeExpenseCard(expenseData: ExpenseData('Income', '\$4,500.00', Icons.arrow_upward_rounded))),
                SizedBox(
                  width: defaultSpacing,
                ),
                Expanded(child: IncomeExpenseCard(expenseData: ExpenseData('Expense', '\$2,000.00', Icons.arrow_downward_rounded))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}