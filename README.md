## About

**Flutter_redux** is a simple flutter application. It demonstrates how to implement Redux for Dart.

## Redux

  Redux.JS author advice : If you've got a simple app, use the simplest thing possible. In Flutter, StatefulWidget is perfect for a simple counter app.

  However, say you have more complex app, such as an E-commerce app with a Shopping Cart. The Shopping Cart should appear on multiple screens in your app and should be updated by many different types of Widgets on those different screens (An "Add Item to Cart" Widget on all your Product Screens, "Remove Item from Cart" Widget on the Shopping Cart Screen, "Change quantity" Widgets, etc).
   Now, in this case, you could create a Testable ShoppingCart class as a Singleton or Create a Root StatefulWidget that passes the ShoppingCartDown Down Down through your widget hierarchy to the "add to cart" or "remove from cart" Widgets .
   Yet passing the ShoppingCart all over the place can get messy. It also means it's way harder to move that "Add to Item" button to a new location, b/c you'd need up update the Widgets throughout your app that passes the state down.

  Furthermore, you'd need a way to Observe when the ShoppingCart Changes so you could rebuild your Widgets when it does (from an "Add" button to an "Added" button, as an example).
  One way to handle it would be to simply setState every time the ShoppingCart changes in your Root Widget, but then your whole app below the RootWidget would be required to rebuild as well! Flutter is fast, but we should be smart about what we ask Flutter to rebuild!

## Project structure
  * **main.dart** is where navigation live and where Redux's Store is provided to the app, and also the main entry point of the app that initiliaze a new Redux's Store.
  * **common**:
    1. components: Flutter Widget with usage as common
    2. actions: common actions.
    3. reducers: common reducer and main app reducer.
    4. states: common state class.
    5. configs.dart: config of your application.
    6. repository.dart: common api fetch.
    7. state.dart: main state.
    8. store.dart: create redux store.
  * **modules**: every application make up of many module. Sample: todo application make up of user (login information, user infomation, etc), todo (list todo, temp todo, etc). It make simpler to develop and easier finding problems.
    1. components: module's View Widget
    2. containers: where Flutter's widgets are connected to Redux state
    3. state.dart: describe the object Redux's state
    4. repository.dart: api fetch
    5. reducers.dart: module reducer
    6. actions.dart: contains Redux actions that can be triggered from widgets
  * **pages**: Screen of your application which made up of many components of module
  * **styles**: your styles

## Demo
  download at: https://play.google.com/store/apps/details?id=com.zrgteam.tinmoi
 
  Checkout "develop" branch
 
  ![Demo 1](https://github.com/zrg-team/flutter_redux/blob/develop/assets/store/good-1.png?raw=true)
  ![Demo 2](https://github.com/zrg-team/flutter_redux/blob/develop/assets/store/good-2.png?raw=true)
  ![Demo 3](https://github.com/zrg-team/flutter_redux/blob/develop/assets/store/good-3.png?raw=true)
  ![Demo 4](https://github.com/zrg-team/flutter_redux/blob/develop/assets/store/good-4.png?raw=true)

## Install

  + Step 1 : `flutter packages get`
  + Step 2 : Create a firebase project at `https://firebase.google.com/`
  + Step 3 : Put firebase's project file into `android/app/google-services.json` and `ios/Runner/GoogleService-Info.plist`
  + Step 4 : Correct your admob APPLICATION_ID in `android/app/src/AndroidManifest.xml`
  
  **Checkout branch `starter` for easier setup**

## Donate
  ethereum address: 0x46D1c53249cA6232eb7d3E046713Bc3D2Ae15BA3
