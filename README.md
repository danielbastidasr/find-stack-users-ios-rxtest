# Find StackOverflow users by name

For this challenge build an app that connects to the
StackExchange API and displays users as described below

## The Goal

The goal of this short program is to show different patterns, that could be useful to build an App.

- RxCocoa
- RxSwift
- RxTest
- MVVM
- Dependency Injection

## Description

The following wireframes describe the screens for the app.  
The ascii-drawings are for reference only.  
Just make sure that the required data is displayed.

### Main Screen

Display an input field, if the lenght of the word is > 5, search for users by that name.  
Display users username.  

```
+--------------------+
|  AppName           |
|--------------------+
| __________  SEARCH | - input  
| ------------------ |
|      Username1     |
| ------------------ |
|      Username2     | -----*tap* -----> Nothing at the moment
| ------------------ |
|      Username3     |
| ------------------ |
|      Username4     |
| ------------------ |
|      Username5     |
+--------------------+
```


## Future Versions

- Add User Detail when Tap
- Add User Pictures

## References

RxSwift - https://github.com/ReactiveX/RxSwift 
Rxtest - https://github.com/ReactiveX/RxSwift/tree/master/RxTest
StackExchange API - https://api.stackexchange.com/docs

