import 'package:flutter/material.dart';

class PopupAnimationDemo extends StatefulWidget {
  @override
  _PopupAnimationDemoState createState() => _PopupAnimationDemoState();
}

class _PopupAnimationDemoState extends State<PopupAnimationDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400), // Total duration for the two-part animation
      vsync: this,
    );

    // Define the scale animation.
    _scaleAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.2),
        weight: 50, // Proportion of the animation duration this tween should take.
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.2, end: 1.0),
        weight: 50, // Proportion of the animation duration this tween should take.
      ),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start the animation when the widget is built.

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _LogOutDialog(BuildContext context) {
    showGeneralDialog(context: context,barrierColor: Color(0x25282F5F),transitionDuration: Duration(seconds: 0), pageBuilder: (BuildContext buildContext,
        Animation animation,
        Animation secondaryAnimation) {
      return Center(
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child:  Container(
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                      ),
                      height: 100,
                      width: 270,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height:40,child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text(
                            'Are you sure',
                            style: TextStyle(fontSize: 14,
                              color: Colors.black,
                              backgroundColor: Colors.transparent),
                              )
                              ]
                          )
                          ),
                          Spacer(),
                          SizedBox(

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextButton(onPressed: (){
                                    Navigator.pop(context);
                                  },
                                      child: Text('Ok',style: TextStyle(color: Colors.red),)),
                                ),

                                Expanded(
                                  child: TextButton(onPressed: (){
                                  Navigator.pop(context);
                                },
                                    child: Text('Cancel',style: TextStyle(color: Colors.blue),)),
                  )
                              ],

                            ),
                          ),
                        ],
                      ),


                    ),

                  ),
      );
    }
    );
    // showDialog(
    //   barrierDismissible: true,
    //   context: context,
    //   builder: (BuildContext context) {
    //     return  AlertDialog(
    //       // backgroundColor: Colors.white60,
    //
    //       content: Center(
    //         child: ScaleTransition(
    //           scale: _scaleAnimation,
    //           child:  Container(color: Colors.black,height: 400,width: 200,),
    //
    //         ),
    //       ),
    //
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 10, 31, 48),
        child:  Center(
      child: ElevatedButton(
          onPressed: () {
            _LogOutDialog(context);
            _controller.forward();
          },
          child: Text('Log Out'),

      ),
    ));
  }
}
