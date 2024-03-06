import 'package:flutter/material.dart';

import '../../const/color.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons.arrow_back_sharp,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text('Privacy Policy',
                        style: TextStyle(
                            color: radiumColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w600)),
                  ),
                  Spacer(),
                  SizedBox(width: 35)
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
                width: double.infinity,
                color: Colors.white.withOpacity(0.2),
                height: 0.5),
            const Expanded(
              child: Scrollbar(
                thickness: 0.5,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non lorem euismod, mollis risus id, ornare urna. Suspendisse elementum ultricies lorem nec auctor. Aenean ac pharetra ante. Vestibulum eget tempor arcu. Suspendisse semper, velit sit amet feugiat laoreet, tortor urna mollis magna, vitae mollis dui est et ipsum. Aliquam quis fringilla mauris. Vivamus sit amet lobortis tellus. Fusce rutrum dapibus vehicula. Curabitur nec nibh in eros aliquet dapibus at id dolor. Ut eleifend velit at purus vestibulum pulvinar. Praesent dignissim, lectus ut venenatis sollicitudin, orci nunc accumsan metus, nec euismod risus nunc ut dolor. Pellentesque sed ultricies nulla.
\nCras a egestas tortor. Maecenas viverra tempor nisl, non dignissim augue suscipit ut. Phasellus laoreet nibh gravida nunc pharetra pretium. Sed sit amet nibh tempor nisl commodo semper quis a magna. Curabitur fringilla tortor sit amet pretium ultricies. Donec dignissim dolor id augue mollis gravida. Aliquam tempor orci libero, id mattis lorem porta et. Cras varius nisi in orci ultricies viverra. Maecenas viverra quam eu vehicula viverra. Aenean ante est, molestie nec ultrices blandit, tempor a nisl. Pellentesque at fringilla urna. Proin consectetur risus ex, nec convallis nibh pulvinar vitae.

Cras mattis imperdiet dignissim. Phasellus blandit, tortor ac accumsan gravida, est neque mattis est, non imperdiet massa libero sit amet lectus. Sed fermentum nisl a mauris auctor, in aliquam sapien faucibus. Vestibulum interdum sem in faucibus laoreet. Ut eleifend posuere nunc eu sagittis. Pellentesque mattis congue tincidunt. Morbi nec ex non eros auctor maximus nec at est. Ut iaculis risus at tincidunt efficitur. Curabitur vitae nisl in ipsum auctor condimentum et a felis. Quisque congue rutrum lorem, vel tempor urna feugiat et. Nulla faucibus vulputate erat, sed sagittis risus maximus a. Integer posuere efficitur semper. Praesent efficitur mattis neque, sit amet interdum nisi dignissim sit amet.

Curabitur viverra sem vel varius condimentum. Nulla iaculis, risus at mattis euismod, libero nulla venenatis augue, in venenatis nibh enim nec dolor. Duis vel tincidunt ipsum, a imperdiet dui. Donec magna magna, auctor eu massa eget, tristique fringilla nisi. Proin venenatis cursus lacus at mollis. Proin tempus arcu eget ligula auctor, id aliquam erat tincidunt. Quisque porta tortor ut enim consequat viverra. Praesent maximus auctor ligula, vel vehicula leo ullamcorper et. Phasellus hendrerit urna id nisi aliquet auctor. Morbi tellus arcu, ornare ac auctor in, elementum tempus enim.

Duis luctus, velit vitae feugiat vulputate, diam est molestie lorem, non dapibus lorem ligula ut diam. Maecenas aliquet lectus ipsum, molestie aliquam erat ullamcorper laoreet. Suspendisse non scelerisque tellus, ac vulputate nisi. Mauris vestibulum at libero sit amet lobortis. Sed porttitor lorem a nisi ornare, vel mattis ipsum condimentum. Ut commodo dignissim ligula, sed rutrum lectus rhoncus pretium. Sed efficitur orci et egestas elementum.''',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
