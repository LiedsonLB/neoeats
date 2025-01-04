import 'package:flutter/material.dart';
import 'package:neoeats/core/constants/colors.dart';
import 'package:neoeats/features/ui/pages/details/details_page.dart';

class FoodListCard extends StatelessWidget {
  const FoodListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailsPage(
            ),
          ),
        );
      },
    
    
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), 
      ),
      elevation: 4, 
      margin: const EdgeInsets.only(bottom: 8), 
      child: Padding(
        padding: const EdgeInsets.all(12.0), 
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/image/logo.png',
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pizza de Parrila',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'R\$ 98.00',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Adicionar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
