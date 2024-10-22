import 'package:bem_estar_flutter/data/data-saude.dart';
import 'package:bem_estar_flutter/util/responsive.dart';
import 'package:bem_estar_flutter/widgets/custom-card-widget.dart';
import 'package:flutter/material.dart';

class AtividadesWidget extends StatelessWidget {
  const AtividadesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final detalheSaude = DataSaude();

    return GridView.builder(
      itemCount: detalheSaude.saudeData.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
        crossAxisSpacing: Responsive.isMobile(context) ? 12 : 15,
        mainAxisSpacing: 12.0,
      ),
      itemBuilder: (context, index) => CustomCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              detalheSaude.saudeData[index].icone,
              width: 30,
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 4),
              child: Text(
                detalheSaude.saudeData[index].valor,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              detalheSaude.saudeData[index].titulo,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
