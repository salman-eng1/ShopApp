
import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingMode{
  final String image;
  final String title;
  final String body;
  
  BoardingMode({
   required this.image,
   required this.title,
   required this.body,
});
  
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController=PageController();

  List<BoardingMode> boarding=[

    BoardingMode(
  image: 'assets/images/onboard_1.png',
  title: 'Screen Title 1',
  body: 'body 1'
  ),

    BoardingMode(
        image: 'assets/images/onboard_2.png',
        title: 'Screen Title 2',
        body: 'body 2'
    ),

    BoardingMode(
        image: 'assets/images/onboard_3.png',
        title: 'Screen Title 3',
        body: 'body 3'
    ),

  ];
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true)!.then((value){
      if(value){
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  bool isLastPageViewer=false;
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              text: 'skip',
              onPressed: submit,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
              itemCount:boarding.length,
                controller: boardController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index)
                {
                  if ( index == boarding.length-1 ){
                    setState(() {
                      isLastPageViewer=true;

                    });
                  }else{
                    setState(() {
                      isLastPageViewer=false;
                    });
                  }
              },),

            ),
            SizedBox(height: 40.0,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      expansionFactor: 5,
                      activeDotColor: defaultColor,
                      dotWidth: 10.0,
                      spacing: 5.0,
                    ),
                    count: boarding.length,

                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if (isLastPageViewer==true) {
                      submit();
                    }else{
                      boardController.nextPage(
                        duration: Duration
                          (
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                    },

                child: Icon(Icons.arrow_forward_ios),)
              ],
            ),
          ],
        ),
      ),
    );
   }

   Widget buildBoardingItem(BoardingMode model)=>Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Expanded(
         child: Image(
           image: AssetImage('${model.image}'),
         ),
       ),
       SizedBox(height: 15.0,),
       Text('${model.title}',
         style: TextStyle(
           fontSize: 24.0,
         ),
       ),
       SizedBox(height: 15.0,),
       Text('${model.body}',
         style: TextStyle(
           fontSize: 14.0,
         ),
       ),
       SizedBox(height: 15.0,),


     ],
   );
}
