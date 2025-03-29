import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/utils/constants.dart';

class ExpenseData {
  final String label;
  final String amount;
  final IconData icon;

  const ExpenseData(
    this.label,
    this.amount,
    this.icon,
  );
}

class IncomeExpenseCard extends StatelessWidget {
  final ExpenseData expenseData;
  
  const IncomeExpenseCard({super.key, required this.expenseData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultSpacing),
      decoration: BoxDecoration(
        color: expenseData.label == 'Income' ? primaryDark : accent,
        borderRadius: const BorderRadius.all(Radius.circular(defaultRadius))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(expenseData.label),
              Text(expenseData.amount)
            ],
          ),
          Icon(expenseData.icon)
        ],
      ),
    );
  }
}