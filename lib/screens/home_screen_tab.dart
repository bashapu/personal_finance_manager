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
            ListTile(
              title: const Text('Hey! Bharath!'),
              leading: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(defaultRadius)),
                child: Image.asset('assets/images/avatar.jpeg'),
              ),
              trailing: Image.asset('assets/icons/bell.png'),
            ),
            SizedBox(height: defaultSpacing),
            Center(
              child: Column(
                children: [
                  Text(
                    '\$4,586.00',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      // fontSize: fontSizeHeading,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: defaultSpacing / 2),
                  Text(
                    'Total Balance',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: fontLight),
                  )
                ],
              ),
            ),
            SizedBox(height: defaultSpacing * 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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