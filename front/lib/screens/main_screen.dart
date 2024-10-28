import 'package:bem_estar_flutter/util/responsive.dart';
import 'package:bem_estar_flutter/widgets/dashboard-widget.dart';
import 'package:bem_estar_flutter/widgets/menu-lateral.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: MenuLateral(),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              Expanded(
                flex: 2,
                child: SizedBox(
                  child: MenuLateral(),
                ),
              ),
            Expanded(
              flex: 7,
              child: DashboardWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
