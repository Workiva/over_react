# OverReact Redux Example "Todo" Application

## Running
```
pub get
webdev serve
```

Open [http://localhost:8080](http://localhost:8080).

## Using Redux Dev Tools
This example app is already set up to utilize a `DevToolsStore` so 
that you can inspect the data using the Redux Devtools extension!

Download the Redux Devtools extension:
  - [Google Chrome Extension](https://chrome.google.com/webstore/detail/redux-devtools/lmhkpmbekcpmknklioeibfkpmmfibljd?hl=en)
  - [Firefox Extension](https://addons.mozilla.org/en-US/firefox/addon/reduxdevtools/) 

> Additional information about `redux_dev_tools` and `DevToolsStore`s can be found [here](https://github.com/brianegan/redux_dev_tools#redux_dev_tools)

## Compiling Sass

To compile the `.scss` file(s) into CSS, run 

```
pub run w_common:compile_sass -s expanded
```
