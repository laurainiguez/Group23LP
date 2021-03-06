import 'package:flutter/material.dart';
import 'package:my_recipe_box/getrecipes.dart';

class TodaysRecipes extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    List<String> recipes = <String>["Recipe Placeholder 1", "Recipe Placeholder 2", "Recipe Placeholder 3"];
    //List<String> ingredients = <String>['Ingredient Placeholder 1', 'Recipe Placeholder 2', 'Recipe Placeholder 3'];
    return Container(
        color: Colors.green[50], // change this color to change the background color
        //backgroundColor: Colors.white,

        child: new Scaffold (
            backgroundColor: Colors.green[50],
            body: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: recipes.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Card(

                    child: Column(


                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(

                          leading: Icon(Icons.local_dining),
                          title: Text("\n${recipes[index]}"),
                          subtitle: Text("More information can go here, such as author name, or ingredients"),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text("View Recipe"),
                              color: Colors.red[400],
                              onPressed: () {
                                // NOTE: this is what happens when the "Get Recipe" button is pressed
                              },
                            ),
                            /*FlatButton(
                       child: const Text('another button could go here'),
                       onPressed: () {/* ... */},
                     ), */
                          ],
                        ),

                      ],
                    ),
                  ),

                );


              },

            ),

        )





    );
  }


}

/*

        FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text('Approve'),
          icon: Icon(Icons.thumb_up),
          backgroundColor: Colors.pink,
        ),
 */

